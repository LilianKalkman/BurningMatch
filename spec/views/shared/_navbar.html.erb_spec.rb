# spec/views/shared/_navbar.html.erb_spec.rb
#WORKING
require 'rails_helper'

describe "shared/_navbar.html.erb" do
  before { sign_in user }
  let(:user) {create :user}

  it "renders name of user" do
    render
    expect(rendered).to have_content user.name
  end

  context "as admin" do
    let(:user) { create :user, email: "Arno@school.com", password: "123456", admin: true }
    it "renders overview users" do
      render
      expect(rendered).to have_content("Overview Users")
    end

    it "renders student matches" do
      render
      expect(rendered).to have_content("Student Matches")
    end

    it "renders matching statistics" do
      render
      expect(rendered).to have_content("Matching Statistics")
    end
  end

  context "as student" do
    let(:user) { create :user, email: "Lilian@school.com", password: "123456", admin: false }
    it "renders my matches" do
      render
      expect(rendered).to have_content("My Matches")
    end
  end
end
