require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /index" do
    it "returns HTTP success" do
      get '/users'
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /users" do
    context "with valid users" do
      let(:csv_file) { fixture_file_upload('valid_users.csv', 'text/csv') }

      it "creates users from the CSV file" do
        expect {
          post users_path, params: { file: csv_file }, headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
        }.to change { User.count }.by(1)

        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid users" do
      let(:csv_file) { fixture_file_upload('invalid_users.csv', 'text/csv') }

      it "does not create users from the CSV file" do
        expect {
          post users_path, params: { file: csv_file }, headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
        }.not_to change { User.count }

        expect(response).to have_http_status(:ok)
      end
    end
  end
end
