#WORKING
require 'rails_helper'

RSpec.describe "users/index.html.erb", type: :view do
  before {login_as user}

  context "as an admin" do
    let (:user) { create :user, email: "Arno@school.com", password: "123456", admin: true }
    it "shows all users" do
      render
      expect(rendered).to have_content(user.email)
    end

  end

  context "as a student" do
    let(:user) { create :user, email: "Lilian@school.com", password:"123456", admin: false}
    it "does not show all users" do
      render
      expect(rendered).to have_content(user.email)
    end
  end


end
