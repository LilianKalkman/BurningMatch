#WORKING
require 'rails_helper'

describe "As an admin you can see a list of studentmatches" do
  before { login_as user_admin }
  let(:user_admin) { create :user, email: "Arno@school.com", password:"123456", admin: true}
  let(:match) { create :match, date: "date", student1: user, student2: "adg" }
  let(:match2) { create :match, date: "now", student1: "iemand", student2: "lhage"}

  it "shows student matches" do
    visit matches_url
    expect(page).to have_content (:match)
    expect(page).to have_content (:match2)
  end
end
