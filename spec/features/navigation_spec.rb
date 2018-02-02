#spec/features/navigation_spec.rb
require 'rails_helper'
#NOT WORKING
describe "navigations for students" do
  before {login_as user}
  let(:user) { create :user, email: "Lilian@school.com", password:"123456", admin: false }

  it "allows navigating from root page to my matches" do
    visit root_url
    click_link "My Matches"
    expect(current_path).to eq(mymatches_path)
  end
end


describe "navigations for admin" do
  before {login_as user}
  let(:user) { create :user, email: "Arno@school.com", password: "123456", admin: true }

  it "navigates to student matches" do
    visit root_url
    click_link "Student Matches"
    expect(current_path).to eq(matches_path)
  end
end
