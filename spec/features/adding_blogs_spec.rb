require 'spec_helper'

require_relative 'helpers/session'
include SessionHelpers

feature "User adds a new blog" do

  before(:each) do
    User.create(:name => "Marissa Mayer",
                :username => "MarissaM",
                :email => "marissa@example.com",
                :password => "yahoo!",
                :password_confirmation => "yahoo!")
  end

  scenario "only when signed in" do
    visit ('/')
    expect(page).not_to have_content("Url:")
    sign_in('MarissaM', 'yahoo!')
    expect(page).to have_content("Url:")
    expect{add_blog("http://www.blog.com/", ['personal'])}.to change{Blog.count}.by(1)
    expect(page).to have_link("blog.com")
  end

  scenario "with a few tags" do
    visit "/blogs/new"
    add_blog("http://www.blog.com/", ['personal'])
    blog = Blog.first
    expect(blog.tags.map(&:text)).to include "personal"
  end

  scenario "that converts to a http link" do
    sign_in('MarissaM', 'yahoo!')
    add_blog("www.blog.com", ['personal'])
    expect(page).to have_link("blog.com", :href => 'http://www.blog.com')
  end


end