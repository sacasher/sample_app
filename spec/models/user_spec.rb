require 'rails_helper'

RSpec.describe User, :type => :model do
  before do
    @user = User.new(
      name: "Example User",
      email: "user@example.com",
      password: "foobar",
      password_confirmation: "foobar")
  end
  subject{@user}
  it{expect(@user).to respond_to(:name) }
  it{expect(@user).to respond_to(:email) }
  it{expect(@user).to respond_to(:password_digest) }
  it{expect(@user).to respond_to(:password) }
  it{expect(@user).to respond_to(:password_confirmation) }
  it{expect(@user).to respond_to(:authenticate) }
  it{expect(@user).to be_valid }

  describe "When name is no present" do
    before{@user.name = ""}
    it{expect(@user).to_not be_valid }
  end

  describe "When email is no present" do
    before{@user.email = ""}
    it{expect(@user).to_not be_valid }
  end

  describe "When name is too long" do
    before{@user.name = "a" * 51}
    it{expect(@user).to_not be_valid }
  end

  describe "When email format is invalid" do
    it "Should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example@foo.]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).to_not be_valid
      end
    end
  end

  describe "When email format is valid" do
    it "Should be invalid" do
      addresses = %w[user@foo.com A_user@foo.v.org example@foo.com a+b@baz.cn]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "When email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
 
    it{expect(@user).to_not be_valid }
  end

  describe "When password is not present" do
    before{@user.password=@user.password_confirmation=" "}
    it{expect(@user).to_not be_valid }
  end

  describe "When password doesn't match confirmation" do
    before{@user.password_confirmation = "missmatch"}
    it{expect(@user).to_not be_valid }
  end

  describe "When password confirmation is nil" do
    before{@user.password_confirmation = nil}
    it{expect(@user).to_not be_valid }
  end

  describe "When password is too short" do
    before{@user.password=@user.password_confirmation="a"*5}
    it{expect(@user).to_not be_valid }
  end

  describe "Return value of authenticate method" do
    before{@user.save}
    let(:found_user){User.find_by_email(@user.email)}

    describe "with valid password" do
      it{expect(@user) == found_user.authenticate(@user.password)}
    end

    describe "with invalid password" do
      let(:user_for_invalid_password){found_user.authenticate("invalid")}
      it{expect(@user) == user_for_invalid_password}
      specify {expect(user_for_invalid_password).to be false}
    end
  end
end
