#spec/features/navigation_spec.rb
require 'rails_helper'

describe "navigations for students" do
  before {login_as user}
  let(:user) { create :user, email: "Lilian@school.com", password:"123456", admin: false }

  it "allows navigating from root page to my matches" do
    visit root_url

    click_link "My Matches"

    expect(current_path).to eq(mymatches_path)
  end

end
