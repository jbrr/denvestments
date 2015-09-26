require "rails_helper"

feature "Visitor logging in" do
  scenario "works with correct login information" do
    User.create(username: "alice", password: "secret")
    visit "/"
    click_link "Log In"
    fill_in "user[username]", with: "alice"
    fill_in "user[password]", with: "secret"
    click_button "Log In"

    expect(current_path).to eq("/dashboard")
    expect(page).to have_content("alice")
    visit "/"
    within ".navbar" do
      expect(page).to have_content("alice")
      expect(page).to have_link("logout")
      expect(page).to have_no_link("Log In")
    end
  end

  scenario "doesn't work with invalid login information" do
    visit "/"
    click_link "Log In"
    fill_in "user[username]", with: "alice"
    fill_in "user[password]", with: "secret"
    click_button "Log In"

    expect(current_path).to eq("/login")
    expect(page).to have_content("Incorrect login")
  end
end