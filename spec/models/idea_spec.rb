require 'rails_helper'

RSpec.describe Idea, :type => :model do

  describe "by creation" do

    context "is valid with valid parameters" do
      it 'is created' do
        expect(create(:idea)).to be_valid
      end
      it "is invalid with invalid parameters" do
        expect(build(:invalid_idea)).not_to be_valid
      end
    end
  end

  describe "by validations" do
    it "must have iser id" do
      user = create(:user)
      idea = create(:idea, user_id: user.id)
      expect(idea.user_id).not_to be_nil
    end

    it 'must have category id' do
      category = Category.first
      idea = create(:idea, category_id: category.id)
      expect(idea.category_id).not_to be_nil
    end

    # Title
    it 'must have title' do
      expect(subject).to validate_presence_of :title
    end 
    it 'must have title lenght from 5 to 40 characters' do
      expect(subject).to ensure_length_of(:title).is_at_least(5).is_at_most(40)
    end
    it 'must have unique title' do
      expect(subject).to validate_uniqueness_of :title
    end 

    #Synopsis
    it 'must have synopsis' do
      expect(subject).to validate_presence_of :synopsis
    end  
    it 'must have synopsis lenght from 5 to 150 characters' do
      expect(subject).to ensure_length_of(:synopsis).is_at_least(5).is_at_most(150)
    end

    # Problem
    it 'must have problem description' do
      expect(subject).to validate_presence_of :problem
    end  
    it 'must have problem description lenght from 5 to 2500 characters' do
      expect(subject).to ensure_length_of(:problem).is_at_least(5).is_at_most(2500)
    end

    # Background
    it 'must have background description' do
      expect(subject).to validate_presence_of :background
    end  
    it 'must have background description lenght from 5 to 2500 characters' do
      expect(subject).to ensure_length_of(:background).is_at_least(5).is_at_most(2500)
    end

    # Solution
    it 'must have solution description' do
      expect(subject).to validate_presence_of :solution
    end  
    it 'must have solution description lenght from 5 to 2500 characters' do
      expect(subject).to ensure_length_of(:solution).is_at_least(5).is_at_most(2500)
    end

    # Links
    it 'must have links lenght from 5 to 1000 characters' do
      expect(subject).to ensure_length_of(:links).is_at_most(1000)
    end

    it 'must have pictures'

    # # allow_mass_assignment_of to controller
    # it { is_expecter allow_mass_assignment_of(:title) }

  end

  describe "Class methods" do
    
    # before(:each) { @user = create(:user) }

    # subject { @user }
    
    # it { is_expected.to respond_to(:email) }

    # it "a string returns from #fullname " do
    #   expect(@user.fullname).to match "#{@user.fname} #{@user.lname}"
    # end

    # context "builds correct country,role and contact data" do
    #   # let!(:user) { create(:user) }

    #   it "has correct country" do
    #     # allow(user).to receive(:country) { 'Россия' }
    #     expect(@user.country.name).to match /Россия/
    #   end
    #   it "has correct role" do
    #     # allow(user).to receive(:role) { 'Member' }
    #     expect(@user.role.name).to match /Member/
    #   end
    #   it "has correct contact data" do
    #     expect(@user.contact).to be_truthy
    #   end

    # end

  end


end
