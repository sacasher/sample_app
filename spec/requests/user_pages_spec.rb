require 'rails_helper'

def full_title page_title
  base_title = 'Ruby on Rails Tutorial Sample App'
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

RSpec.describe "UserPages", :type => :feature do
  subject {page}

  describe "signup page" do
    before {visit signup_path }
    it {expect(page).to have_selector('h1',text: 'Sign up')}
    it {expect(page).to have_title full_title 'Sign up'}
  end
  
  describe "profile page" do
    let(:foobar) { FactoryGirl.create :user}
    before {visit user_path foobar}

    it {expect(page).to have_selector('h1',text: foobar.name)}
    it {expect(page).to have_title full_title foobar.name}
  end

  describe "signup" do
    before{ visit signup_path }
    let(:submit) {"Create my account"}
    describe "With invalid information" do
      it "Should not create a user" do
        expect {click_button submit}.not_to change(User,:count)
      end

      describe "after submission" do
        before{click_button submit}
        it{expect(page).to have_title "Sign up"}
        it{expect(page).to have_content "error"}
        it{expect(page).not_to have_content "Password digest"}
      end
    end

    describe "With valid information" do
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "Should create a user" do
        expect {click_button submit}.to change(User,:count).by 1
      end

      describe "after saving a user" do
        before{click_button submit}
        let(:user) {User.find_by_email("user@example.com")}
        it{expect(page).to have_title user.name}
        it{expect(page).to have_selector("div.alert.alert-success", text: "Welcome")}
      end
    end

  end
end
