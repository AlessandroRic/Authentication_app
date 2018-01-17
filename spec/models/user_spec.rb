require 'rails_helper'
describe User, type: :model do
  describe 'validations' do
    before do
      @user = User.create(first_name: 'Ale', last_name: 'ferreira', email: 'ale@test.com')
    end

    it 'can be created' do
      expect(@user).to be_valid
    end

    it 'cannot be created without a first name' do
      @user.first_name = nil
      expect(@user).not_to be_valid
    end

    it 'cannot be created without a last name' do
      @user.last_name = nil
      expect(@user).not_to be_valid
    end

    it 'cannot be created without an email' do
      @user.email = nil
      expect(@user).not_to be_valid
    end

    it 'cannot have a too short first name' do
      @user.first_name = 'a' * 2
      expect(@user).not_to be_valid
    end

    it 'cannot have a too long first name' do
      @user.first_name = 'a' * 25
      expect(@user).not_to be_valid
    end


  end
end