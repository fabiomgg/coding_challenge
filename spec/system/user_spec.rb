require 'rails_helper'

describe 'Process CSV users file', type: :system do
  context 'with valid user' do
    it 'shows success message' do
      visit users_path

      within("form") do
        attach_file('file', Rails.root.join('spec', 'fixtures', 'files', 'valid_users.csv'))
        click_on('Upload')
      end

      expect(page).to have_content(/User [\w\s]+ was successfully created/)
    end
  end

  context 'with invalid user' do
    it 'shows error message' do
      visit users_path

      within("form") do
        attach_file('file', Rails.root.join('spec', 'fixtures', 'files', 'invalid_users.csv'))
        click_on('Upload')
      end

      expect(page).to have_content(/User [\w\s]+ was not created/)
    end
  end
end
