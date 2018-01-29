require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "is invalid when no email is given" do
      user = User.new(email: "", password: "123456")
      user.valid?
      expect(user.errors).to have_key(:email)
    end
  end
end
