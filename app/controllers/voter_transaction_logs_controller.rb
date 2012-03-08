class VoterTransactionLogsController < ApplicationController
  # GET /voter_transaction_logs
  # GET /voter_transaction_logs.json
  def index
    @voter_transaction_logs = VoterTransactionLog.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @voter_transaction_logs }
    end
  end

  # GET /voter_transaction_logs/1
  # GET /voter_transaction_logs/1.json
  def show
    @voter_transaction_log = VoterTransactionLog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @voter_transaction_log }
    end
  end

  # GET /voter_transaction_logs/new
  # GET /voter_transaction_logs/new.json
  def new
    @voter_transaction_log = VoterTransactionLog.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @voter_transaction_log }
    end
  end

  # GET /voter_transaction_logs/1/edit
  def edit
    @voter_transaction_log = VoterTransactionLog.find(params[:id])
  end

  # POST /voter_transaction_logs
  # POST /voter_transaction_logs.json
  def create
    @voter_transaction_log = VoterTransactionLog.new(params[:voter_transaction_log])

    respond_to do |format|
      if @voter_transaction_log.save
        format.html { redirect_to @voter_transaction_log, notice: 'Voter transaction log was successfully created.' }
        format.json { render json: @voter_transaction_log, status: :created, location: @voter_transaction_log }
      else
        format.html { render action: "new" }
        format.json { render json: @voter_transaction_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /voter_transaction_logs/1
  # PUT /voter_transaction_logs/1.json
  def update
    @voter_transaction_log = VoterTransactionLog.find(params[:id])

    respond_to do |format|
      if @voter_transaction_log.update_attributes(params[:voter_transaction_log])
        format.html { redirect_to @voter_transaction_log, notice: 'Voter transaction log was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @voter_transaction_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /voter_transaction_logs/1
  # DELETE /voter_transaction_logs/1.json
  def destroy
    @voter_transaction_log = VoterTransactionLog.find(params[:id])
    @voter_transaction_log.destroy

    respond_to do |format|
      format.html { redirect_to voter_transaction_logs_url }
      format.json { head :no_content }
    end
  end
end
