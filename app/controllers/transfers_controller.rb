class TransfersController < ApplicationController
  require 'csv'

  def create
    csv_file = params[:file]

    # Ensure that a CSV file was uploaded
    if csv_file.content_type != 'text/csv'
      flash[:error] = 'Please upload a CSV file'
      redirect_to accounts_path and return
    end

    errors = []
    CSV.foreach(csv_file.path, headers: false).with_index do |row, i|
      transfer = create_transfer(row)
      if transfer.errors.present?
        errors << "Row #{i + 1} cannot be processed: #{transfer.errors.full_messages.to_sentence}"
      end
    end
    flash[:notice] = "CSV file uploaded successfully. #{('Errors been found:' + errors.to_s) if errors.present?}"
    redirect_to accounts_path
  end

  private

  def create_transfer(row)
    from_account = Account.find_by(number: row[0])
    to_account = Account.find_by(number: row[1])
    Transfer.create(
      from_account: from_account,
      to_account: to_account,
      amount: row[2].try(:to_f)
    )
  end

end
