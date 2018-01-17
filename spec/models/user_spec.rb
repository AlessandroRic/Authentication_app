require 'rails_helper'
describe User, type: :model do
  describe 'validations' do
    before do
      @user = User.create(first_name: 'Ale', last_name: 'ferreira', email: 'ale@test.com',
                          password: 'foobar', password_confirmation: 'foobar')
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
      @user.first_name = 'a'
      expect(@user).not_to be_valid
    end

    it 'cannot have a too long first name' do
      @user.first_name = 'a' * 35
      expect(@user).not_to be_valid
    end

    it 'cannot have an invalid adress' do
      invalid_adresses = %w[user@example,com user_at_foo.org user.name@example.
      foo@bar_baz.com foo@bar+baz.com]

      invalid_adresses.each do |invalid_adress|
        @user.email = invalid_adress
        expect(@user).not_to be_valid
      end
    end

    it 'must have a unique email adress' do
      @user = User.new(first_name: 'Jane', last_name: 'Doe', email: 'ALE@test.com')
      expect(@user).not_to be_valid
    end

    it 'must have a non blank password' do
      @user.password = @user.password_confirmation = ''*6
      expect(@user).not_to be_valid
    end

    it 'must have a password with a minimum lenght' do
      @user.password = @user.password_confirmation = 'a'*5
    end

  end
end