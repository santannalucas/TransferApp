require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  describe "GET #index" do
    it "assigns @accounts" do
      accounts = Account.all
      get :index
      expect(assigns(:accounts)).to eq(accounts)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    it "assigns the requested account to @account" do
      account = Account.first
      get :show, params: { id: account.id }
      expect(assigns(:account)).to eq(account)
    end

    it "assigns transfers to @transfers" do
      account = Account.first
      transfer = Transfer.account(account.id)
      get :show, params: { id: account.id }
      expect(assigns(:transfers)).to eq(transfer)
    end

    it "renders the show template" do
      account = Account.first
      get :show, params: { id: account.id }
      expect(response).to render_template("show")
    end
  end
end