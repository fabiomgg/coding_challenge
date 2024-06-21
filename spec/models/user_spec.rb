require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:user){ build(:user) }

    it { should validate_presence_of(:name) }
    it { should validate_length_of(:password).is_at_least(10) }
    it { should validate_length_of(:password).is_at_most(16) }

    it 'is expected to validate that :password contains at least one lowercase character' do
      user.password = 'ABC_123_CDE'
      expect(user).to_not be_valid
      expect(user.errors[:password]).to include('must contain at least one lowercase character, one uppercase character and one digit')
    end

    it 'is expected to validate that :password contains at least one uppercase character' do
      user.password = 'abc_123_cde'
      expect(user).to_not be_valid
      expect(user.errors[:password]).to include('must contain at least one lowercase character, one uppercase character and one digit')
    end

    it 'is expected to validate that :password contains at least one digit' do
      user.password = 'Abc_cde_fgh'
      expect(user).to_not be_valid
      expect(user.errors[:password]).to include('must contain at least one lowercase character, one uppercase character and one digit')
    end

    it 'is expected to validate that :password does not contain three repeating characters' do
      user.password = 'Abccc_123_cde'
      expect(user).to_not be_valid
      expect(user.errors[:password]).to include('cannot contain three repeating characters')
    end
  end
end
