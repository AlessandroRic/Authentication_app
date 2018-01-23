require 'rails_helper'

describe UsersController, type: :controller do
  describe 'GET #edit, PATCH #update' do

    before :each do
      @user = FactoryGirl.create(:user)
      @other_user = FactoryGirl.create(:other_user)
    end

    context 'valid attributes' do

      it 'assigns the requested user to @user' do
        log_in_as(@user)
        #get :edit, id: @user, user: FactoryGirl.attributes_for(:user)
        get :edit, params: { id: @user, user: FactoryGirl.attributes_for(:user) }
        expect(assigns(:user)).to eq(@user)
      end

      it 'locates the requested @user' do
        log_in_as(@user)
        # patch :update, id: @user, user: FactoryGirl.attributes_for(:user)
        process :update, method: :patch, params: { id: @user, user: FactoryGirl.attributes_for(:user) }
        expect(assigns(:user)).to eq(@user)
      end

      it "changes @user's attributes" do
        log_in_as(@user)
        # patch :update, id: @user, user: FactoryGirl.attributes_for(:user, first_name: 'Jonnie', last_name: 'Walker')
        process :update, method: :patch, params: { id: @user, user: FactoryGirl.attributes_for(:user, first_name:'alessandro', last_name:'test')}

        @user.reload
        expect(@user.first_name).to eq('alessandro')
        expect(@user.last_name).to eq('test')
      end
      end

      context 'only a logged user can edit and update' do

        it 'redirects edit when not logged in' do
          get :edit, params: { id: @user, user: FactoryGirl.attributes_for(:user) }
          edit_user_path(@user)
          expect(flash[:alert]).not_to be_nil
          expect(@user).to redirect_to login_url
        end

        it 'redirects update when not logged in' do
          process :update, method: :patch, params: { id: @user, user: FactoryGirl.attributes_for(:user) }
          expect(flash[:alert]).not_to be_nil
          expect(@user).to redirect_to login_url
        end
      end

      context 'only the legitimate user can edit and update' do

        it 'redirect edit when logged as the wrong user' do
          log_in_as(@other_user)
          get :edit, params: { id: @user, user: FactoryGirl.attributes_for(:other_user) }
          expect(flash).to match_array([])
          expect(edit_user_path).to redirect_to root_url
        end

        it 'redirect update when logged as the wrong user' do
          log_in_as(@other_user)
          process :update, method: :patch, params: {id: @user, user: FactoryGirl.attributes_for(:other_user)}
          expect(flash).to match_array([])
          expect(user_path).to redirect_to root_url
        end
      end


    # Log in as a particular user
    def log_in_as(user)
      session[:user_id] = user.id

    end


  end
end