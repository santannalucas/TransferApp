class AccountsController < ApplicationController

  def index
    @accounts = Account.all
  end

  def show
    @account = Account.find(params[:id])
    @transfers = Transfer.account(@account.id)
  end

end
