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
end
