require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "is invalid when no email is given" do
      set_user("","123456")
      @user.valid?
      expect(@user.errors).to have_key(:email)
    end

    it "is invalid when no password is given" do
      set_user("mail@mail.com", "")
      @user.valid?
      expect(@user.errors).to have_key(:password)
    end

  # it "is invalid when email already exists" do
  #   set_user("mail@mail.com", "123456")
  #   user2 = @user.dup
  #   # user_with_same_email = @user.email.downcase
  #   user2.save
  #
  #   expect { user2.save! }.to raise_error
  #   end


  end

  def set_user(email, password)
    @user = User.new(email: email, password: password)
  end

end
