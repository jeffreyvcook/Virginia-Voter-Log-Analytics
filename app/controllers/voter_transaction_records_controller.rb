class VoterTransactionRecordsController < ApplicationController
  # GET /voter_transaction_records
  # GET /voter_transaction_records.json
  def index
    @voter_transaction_records = VoterTransactionRecord.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @voter_transaction_records }
    end
  end

  # GET /voter_transaction_records/1
  # GET /voter_transaction_records/1.json
  def show
    @voter_transaction_record = VoterTransactionRecord.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @voter_transaction_record }
    end
  end

  # GET /voter_transaction_records/new
  # GET /voter_transaction_records/new.json
  def new
    @voter_transaction_record = VoterTransactionRecord.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @voter_transaction_record }
    end
  end

  # GET /voter_transaction_records/1/edit
  def edit
    @voter_transaction_record = VoterTransactionRecord.find(params[:id])
  end

  # POST /voter_transaction_records
  # POST /voter_transaction_records.json
  def create
    @voter_transaction_record = VoterTransactionRecord.new(params[:voter_transaction_record])

    respond_to do |format|
      if @voter_transaction_record.save
        format.html { redirect_to @voter_transaction_record, notice: 'Voter transaction record was successfully created.' }
        format.json { render json: @voter_transaction_record, status: :created, location: @voter_transaction_record }
      else
        format.html { render action: "new" }
        format.json { render json: @voter_transaction_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /voter_transaction_records/1
  # PUT /voter_transaction_records/1.json
  def update
    @voter_transaction_record = VoterTransactionRecord.find(params[:id])

    respond_to do |format|
      if @voter_transaction_record.update_attributes(params[:voter_transaction_record])
        format.html { redirect_to @voter_transaction_record, notice: 'Voter transaction record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @voter_transaction_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /voter_transaction_records/1
  # DELETE /voter_transaction_records/1.json
  def destroy
    @voter_transaction_record = VoterTransactionRecord.find(params[:id])
    @voter_transaction_record.destroy

    respond_to do |format|
      format.html { redirect_to voter_transaction_records_url }
      format.json { head :no_content }
    end
  end
end