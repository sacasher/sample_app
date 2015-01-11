require 'rails_helper'

def full_title page_title
  base_title = 'Ruby on Rails Tutorial Sample App'
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

describe "StaticPages", :type => :feature do
  subject{page}
  describe "Home page" do
    before{ visit root_path}

    it{ expect(page).to have_selector('h1',text: 'Sample App')}
    it{ expect(page).to have_title full_title('')}
    it{ expect(page).to_not have_title "| Home"}

  end

  describe "Help page" do
    before{ visit help_path}
    it{ expect(page).to have_selector('h1',text: 'Help') }
    it{ expect(page).to have_title full_title 'Help'}
  end

  describe "About Page" do
    before {visit about_path}
    it{ expect(page).to have_selector('h1',text: 'About Us') }
    it{ expect(page).to have_title full_title "About Us"}
  end

  describe "Contact Page" do
    before{visit contact_path}
    it{ expect(page).to have_selector('h1',text: 'Contact') }
    it{ expect(page).to have_title full_title "Contact"}
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title full_title "About Us"
    click_link "Help"
    expect(page).to have_title full_title "Help"
    click_link "Contact"
    expect(page).to have_title full_title "Contact"
    click_link "Home"
    click_link "Sign up now!"
    expect(page).to have_title full_title 'Sign up'
    click_link "sample app"
    expect(page).to have_title full_title ''
  end
end
