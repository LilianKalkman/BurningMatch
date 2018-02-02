# spec/features/list_mymatches_spec.rb
#NOT WORKING

require 'rails_helper'

describe "As an student you can see a list of all their matches" do
  before { login_as user }
  let(:user) { create :user, email: "Lilian@school.com", password:"123456", admin: false}
  let(:user1) {create :user, email: "Danijel@school.com", password:"123456", admin: false}
  let(:match) { create :match, date: "date", student1: user, student2: user1 }

  it "shows matches" do
    visit mymatches_url
    expect(page).to have_text (user.name)
  end
  it "shows matches" do
    visit mymatches_url
    expect(page).to have_text (:match)
  end
end
