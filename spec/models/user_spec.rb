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


    def set_user(email, password)
      @user = User.new(email: email, password: password)
    end
  end
end
