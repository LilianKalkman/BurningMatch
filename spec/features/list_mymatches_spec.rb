# spec/features/list_mymatches_spec.rb
require 'rails_helper'

describe "As an student you can see a list of all your matches" do
  before { login_as user }
  let(:user) { create :user, email: "Lilian@school.com", password:"123456", admin: false}
  let(:match) { create :match, date: "date", student1: "lilian", student2: "renato"}

  it "shows matches" do
    visit mymatches_url
    expect(page).to have_text("lilian")
    expect(page). to have_text("renato")
  end
end
