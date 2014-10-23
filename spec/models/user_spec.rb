require 'rails_helper'


describe User do

  describe "by registration" do

    context "is valid with valid parameters" do

      it 'is registered' do
        expect(create(:user)).to be_valid
      end

      it "is invalid with invalid parameters" do
        expect(build(:invalid_user)).not_to be_valid
      end

    end

    context "is invalid with wrong parameters" do

      it "is invalid without a first name" do
        user = build(:user,fname: nil)
        expect(user).not_to be_valid
      end

      it "is invalid without a last name" do
        user = build(:user,lname: nil)
        expect(user).not_to be_valid
      end

      it "is invalid without a user name" do
        user = build(:user,lname: nil)
        expect(user).not_to be_valid
      end

      it "is invalid without a email" do
        user = build(:user,email: nil)
        expect(user).not_to be_valid
      end

      it "is invalid without a password" do
        user = build(:user,password: nil)
        expect(user).not_to be_valid
      end

      it "is invalid with a wrong password confirmation" do
        user = build(:user, password_confirmation: "wrong123")
        expect(user).not_to be_valid
      end

      it "is invalid without a terms confirmation" do
        user = build(:user, terms: false)
        expect(user).not_to be_valid
      end

    end
    
  end

  describe "by validations" do
    it 'must have first name' do
      expect(subject).to validate_presence_of :fname
    end 
    it 'must have last name' do
      expect(subject).to validate_presence_of :lname
    end  
    it 'must have user name(login)' do
      expect(subject).to validate_presence_of :name
    end  
    it 'must have email' do
      expect(subject).to validate_presence_of :email
    end

    it 'must have unique name' do
      user = create(:user, slug: 'unique')
      is_expected.to validate_uniqueness_of(:name).case_insensitive
    end

    it 'must have unique email' do
      user = create(:user, slug: 'unique')
      is_expected.to validate_uniqueness_of(:email).case_insensitive
    end

    it 'must have password' do
      expect(subject).to validate_presence_of :password
    end

    it 'must have password at least 8 characters' do
      expect(subject).to ensure_length_of(:password).is_at_least(8)
    end

    it 'must have correct password confirmation' do
      expect(subject).to validate_confirmation_of :password
    end

  end

  describe "Class methods" do
    
    before(:each) { @user = create(:user) }

    subject { @user }
    
    it { is_expected.to respond_to(:email) }

    it "a string returns from #fullname " do
      expect(@user.fullname).to match "#{@user.fname} #{@user.lname}"
    end

    context "builds correct country,role and contact data" do
      # let!(:user) { create(:user) }

      it "has correct country" do
        # allow(user).to receive(:country) { 'Россия' }
        expect(@user.country.name).to match /Россия/
      end
      it "has correct role" do
        # allow(user).to receive(:role) { 'Member' }
        expect(@user.role.name).to match /Member/
      end
      it "has correct contact data" do
        expect(@user.contact).to be_truthy
      end

    end

  end

end
