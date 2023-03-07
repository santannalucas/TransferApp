RSpec.describe TransfersController, type: :controller do

  describe 'POST #create' do
    before { Transfer.delete_all }

    context 'with valid CSV file' do
      let(:file) { fixture_file_upload('transfers.csv', 'text/csv') }
      let(:account1) { create(:account, number: '1234123412341234', initial_balance: 1000.0) }
      let(:account2) { create(:account, number: '5678567856785678', initial_balance: 500.0) }
      it 'creates transfers' do
        post :create, params: { file: file }
        expect(response).to redirect_to(accounts_path)
        expect(flash[:notice]).to eq('CSV file uploaded successfully. ')
        expect(Transfer.count).to eq(2)
      end
    end

    context 'with invalid CSV file' do
      let(:file) { fixture_file_upload('transfers_invalid.csv', 'text/csv') }

      it 'does not create transfers and displays errors' do
        post :create, params: { file: file }
        expect(response).to redirect_to(accounts_path)
        expect(flash[:notice]).to include("From account does not have enough funds")
      end
    end
  end
end