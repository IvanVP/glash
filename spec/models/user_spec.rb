require 'rails_helper'

# describe User do

#   it "is valid with name, email" do
#     expect(build(:user)).to be_valid
#   end

#   it "is invalid with invalid parameters" do
#     expect(build(:invalid_user)).not_to be_valid
#   end

#   context " by validations" do
#     it 'must have first name' do
#       expect(subject).to validate_presence_of :fname
#     end 
#     it 'must have last name' do
#       expect(subject).to validate_presence_of :lname
#     end  
#     it 'must have user name(login)' do
#       expect(subject).to validate_presence_of :name
#     end  
#     it 'must have email' do
#       expect(subject).to validate_presence_of :email
#     end 

#     context "must have unique name and email" do
#       # create(:user, email: "test@example.com") 
#       # build(:user,email: "test@example.com") 
#       subject(:user) { User.create(name: "guest", email: "user@example.com") }
#       it 'must have unique user name' do
#         # expect(create(:user)).to be_valid
#       end 
#       it 'must have unique email' do
#         # expect(subject).to validate_uniqueness_of :email
#       end 
#     end
#     it 'must have unique slug' 
#     it 'must have password' 
#     it 'must have passwordlength  from 8 to 30 symbols' 
#     it "user's password and password confirmation must be the same"  
#   end
# end

describe User do

  before(:each) { @user = User.new(email: 'user@example.com') }

  subject { @user }

  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(@user.email).to match 'user@example.com'
  end

end