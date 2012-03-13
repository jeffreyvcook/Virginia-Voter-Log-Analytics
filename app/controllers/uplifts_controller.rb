require 'nokogiri'

class UpliftsController < ApplicationController

  attr_accessor :uplift_file

  def uplift
    @uplift_msg = ""
    @uplift_xml = ""
    @uplift_err = ""
    unless params['file']
      @uplift_msg = "Error: choose file name"
      render :uplift
      return
    end
    self.uplift_file = params['file'].original_filename
    uploader = LogfileUploader.new
    post = uploader.store!( params['file'] )
    @uplift_msg = "Uploaded: " + self.uplift_file
    self.validateFile("public/uploads/"+self.uplift_file)
  rescue CarrierWave::IntegrityError => e
    @uplift_msg = "Invalid XML file name: "+self.uplift_file
    render :uplift
  rescue => e
    @uplift_msg = "Should't happen #1: "+e.message # JVC temp
    render :uplift
  end

  def validateFile(document_path)
    #use valid? on both objects
    unless (schema = self.readXMLSchema())
      return
    end
    unless (document = self.readXMLDocument(document_path))
      return
    end
    errors = schema.validate(document)
    if (errors.length > 0)
      @uplift_err += "Validation Errors: "      
      errors.each { |e| @uplift_err += e.message }
      render :uplift
    else
      if self.finalizeVTL(document)
        if (@uplift_err == "")
          @uplift_err = "Validation: OK"
        end
        render 'pages/front'
      else
        render :uplift
      end
    end
  rescue => e
    @uplift_err += "Should't happen #2: "+e.message # JVC temp
  end

  def contentOrEmptyStr(xml)
    if xml
      return xml.content
    else
      return ""
    end
  end

  def finalizeVTL(xml)
    origin = self.contentOrEmptyStr(xml % 'header/origin')
    ouniq = self.contentOrEmptyStr(xml % 'header/originUniq')
    logdate = self.contentOrEmptyStr(xml % 'header/date')
    locale = self.contentOrEmptyStr(xml % 'header/locale')
    elec_id = Selection.all[0].eid # JVC this is still wrong
    vtl = VoterTransactionLog.new(:origin => origin,  :origin_uniq => ouniq,
                                  :datime => logdate, :locale => locale,
                                  :election_id => elec_id)
    unless (vtl.save)
      vtl.errors.full_messages.each do |e|
        @uplift_err += " "+e
      end
      return false
    end
    (xml / 'voterTransactionRecord').each do |vtr|
      voter = self.contentOrEmptyStr(vtr % 'voter')
      vtype = self.contentOrEmptyStr(vtr % 'vtype')
      datime = self.contentOrEmptyStr(vtr % 'date')
      action = self.contentOrEmptyStr(vtr % 'action')
      leo = self.contentOrEmptyStr(vtr % 'leo')
      note = self.contentOrEmptyStr(vtr % 'note')
      form = ""
      first = 0
      if (node = vtr % 'form')
        (node / 'type').each do |type|
          if (first == 0)
            form = type.content
            first = 1
          elsif (first == 1)
            form += " | "+type.content
            first = 2
          end
        end
        if (first == 1)
          form += " | "
        end
        form += " | "
        if (item = self.contentOrEmptyStr(node % 'name'))
          form += item
        end
        form += " | "
        if (item = self.contentOrEmptyStr(node % 'number'))
          form += item
        end
      end
      vtr = VoterTransactionRecord.new(:datime => datime, :voter => voter,
                                       :vtype => vtype, :action => action,
                                       :form => form, :leo => leo,:note => note,
                                       :voter_transaction_log_id => vtl.id)
      unless (vtr.save)
        vtr.errors.full_messages.each do |e|
          @uplift_err += " "+e
        end
        return false
      end
    end
    vtl.save
    #@uplift_xml = vtl.to_voter_xml()
    return true
  end

  def xp(xml_text) # from http://vitobotta.com/more-methods-format-beautify-ruby-output-console-logs/
    xsl = <<XSL
  <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="/">
      <xsl:copy-of select="."/>
    </xsl:template>
  </xsl:stylesheet>

XSL

    doc  = Nokogiri::XML(xml_text)
    xslt = Nokogiri::XSLT(xsl)
    out  = xslt.transform(doc)
    puts out.to_xml
  end

  def readXMLSchema
    file = File.read("public/xml/VTL.xsd")
    schema = Nokogiri::XML::Schema(file)
    return schema
  rescue => e
    @uplift_err += "Shouldn't happen #3, invalid built-in schema. "+e.message
    render :uplift
    return false
  end
  
  def readXMLDocument(document_path)
    document = Nokogiri::XML(File.read(document_path))
    return document
  rescue => e
    @uplift_err += "Invalid File format: "+e.message
    render :uplift
    return false
  end

end
