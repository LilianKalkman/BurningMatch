#spec/features/navigation_spec.rb
require 'rails_helper'
#WORKING
describe "navigations for students" do
  before {login_as user_student}
  let(:user_student) { create :user, email: "Lilian@school.com", password:"123456", admin: false }

  it "allows navigating from root page to my matches" do
    visit root_url
    click_link "Show My Matches"
    expect(current_path).to eq(mymatches_path)
  end
  it "allows navigating from root page to my matches" do
    visit root_url
    click_link "My Matches"
    expect(current_path).to eq(mymatches_path)
  end
end

describe "navigations for admin" do
  before {login_as user_admin}
  let(:user_admin) { create :user, email: "Arno@school.com", password: "123456", admin: true }

  it "navigates to student matches" do
    visit root_url
    click_link "Show Student Matches"
    expect(current_path).to eq(matches_path)
  end
  it "navigates to student matches (navbar)" do
    visit root_url
    click_link "Student Matches"
    expect(current_path).to eq(matches_path)
  end

  it "navigates to overview users" do
    visit root_url
    click_link "Show Overview Users"
    expect(current_path).to eq(users_path)
  end

  it "navigates to overview users (navbar)" do
    visit root_url
    click_link "Overview Users"
    expect(current_path).to eq(users_path)
  end

end
