require 'rails_helper'

RSpec.describe CsvUserImportService, type: :service do
  let(:csv_file_path) { Rails.root.join('spec', 'fixtures', 'files', 'valid_users.csv') }
  let(:csv_file) { Rack::Test::UploadedFile.new(csv_file_path, 'text/csv') }
  let(:service) { CsvUserImportService.new(csv_file) }

  describe '#process' do
    context 'with valid users CSV file' do
      it 'creates users from CSV file' do
        expect { service.process }.to change { User.count }.by(1)
      end

      it 'returns success message' do
        results = service.process
        expect(results).to include(/User [\w\s]+ was successfully created/)
      end
    end

    context 'with invalid invalid users CSV file' do
      let(:csv_file_path) { Rails.root.join('spec', 'fixtures', 'files', 'invalid_users.csv') }

      it 'does not create users from CSV file' do
        expect { service.process }.not_to change { User.count }
      end

      it 'returns error message' do
        results = service.process
        expect(results).to include(/User [\w\s]+ was not created/)
      end
    end
  end
end
