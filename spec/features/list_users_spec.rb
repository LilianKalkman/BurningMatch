#spec/features/list_users_spec.rb

require 'rails_helper'

describe "Current user (admin) viewing list of all users" do
  before { login_as user }
  let(:user) { create :user, email: "Arno@school.com", password: "123456", admin: true }

  it "shows list of all users" do
  visit users_url
  expect(page).to have_text("arno@school.com")
  end
end

describe "Current user (student) can not view list of all users" do
  before { login_as user }
  let(:user) { create :user, email: "Lilian@school.com", password:"123456", admin: false}

  it "does not show list of all users" do
    visit users_url
    expect(page).not_to have_text("lilian@school.com")
  end
end
