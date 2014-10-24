require 'rails_helper'

describe UsersController do
  # before :each do
  #   user = create(:user) 
  #   login_as(user, :scope => :user) 
  # end

  describe "GET #index" do

    context 'all users' do
      before :each do

        @user1 = create(:user) 
        @user2 = create(:user)
        @user3 = create(:user)
      end

      xit 'populates an array of all users'  do
        get :index
        expect(assigns(:users)).to be_include([@user1, @user2, @user3])
        # expect(assigns(:users)).to match_array([@user1, @user2, @user3])
      end
      it 'renders the index view' do
        get :index
        expect(response).to render_template :index
      end
    end

    # context 'NonRESTful routes and search' do
    #   it "renders altenative view"
    # end
  end

  describe "GET #show" do
      it 'присваивает запрошенного пользователя to @user' do
        user = create(:user)
        get :show, id: user
        expect(assigns(:user)).to eq(user)
      end 
      it 'показывает show view' do
        user = create(:user)
        get :show, id: user
        expect(response).to render_template :show
        expect(response.status).to eq(200)
        assert_response 200
      end
  end

  # describe "GET #new" do
  #     it 'создает нового пользователя to @user' do
  #       get :new
  #       expect(assigns(:user)).to be_a_new(User)
  #     end  
  #     it 'показывает new view' do
  #       get :new
  #       expect(response).to render_template :new
  #     end
  # end

  # describe "GET #edit" do
  #   it 'assigns requested user to @user' do
  #     user = create(:user)
  #     get :edit, id: user
  #     expect(assigns(:user)).to eq(user)
  #   end

  #   it 'renders edit view' do
  #     user = create(:user)
  #     get :edit, id: user
  #     expect(response).to render_template :edit
  #   end
  # end

  # describe "POST #create" do
  #   context "with valid attributes" do
  #     it 'saves the new user in the database' do
  #       expect{
  #         post :create,
  #         user: attributes_for(:user)
  #         }.to change(User, :count).by(1)
  #     end

  #     it 'redirects to user#show' do
  #       post :create, user: attributes_for(:user)
  #       expect(response).to redirect_to user_path(assigns[:user])
  #     end
  #   end

  #   context "with invalid attributes" do
  #     it 'does not save the new user in the database' do
  #       expect{
  #         post :create,
  #         user: attributes_for(:invalid_user)
  #         }.not_to change(User, :count)
  #     end

  #     it 're-renders the new template' do
  #       post :create, user: attributes_for(:invalid_user)
  #       expect(response).to render_template :new
  #     end
  #   end
  # end

  # describe "PATCH #update" do
  #   before :each do
  #     @user = create(:user, fname: "Ivan", lname: "Petrov")
  #   end
  #   context "with valid attributes" do
  #     it 'find the requested @user' do
  #         patch :update, id: @user, user: attributes_for(:user)
  #         expect(assigns(:user)).to eq(@user)
  #     end

  #     it "changes @user's attributes" do
  #       patch :update, id: @user, user: attributes_for(:user,
  #         fname: "Alex", lname: "Ivanov")
  #       @user.reload
  #       expect(@user.fname).to eq "Alex"
  #       expect(@user.lname).to eq "Ivanov"
  #       expect(@user.fullname).to eq "Alex Ivanov"
  #     end
  #   end

  #   context "with invalid attributes" do
  #     it 'does not save the new user in the database' do
  #       patch :update, id: @user, user: attributes_for(:user,
  #         fname: "Alex", lname: nil)
  #       @user.reload
  #       expect(@user.fname).not_to eq "Alex"
  #       expect(@user.lname).to eq "Petrov"
  #       expect(@user.fullname).to eq "Ivan Petrov"  
  #     end

  #     it 're-renders the new template' do
  #       patch :update, id: @user, user: attributes_for(:invalid_user)
  #       expect(response).to render_template :edit
  #     end
  #   end
  # end

  # describe "DELETE #destroy" do
  #   before :each do
  #     @user = create(:user)
  #   end
  #   it 'deletes the @user' do
  #     expect{ delete :destroy, id: @user}.to change(User, :count).by(-1)
  #   end

  #   it "redirects ro users#index" do
  #     delete :destroy, id: @user
  #     expect(response).to redirect_to(users_path)
  #   end
  # end


end
