require 'spec_helper'

feature "User browses a list of blogs" do

  before(:each) {
    Blog.create(:url => "http://www.blog.com/",
                :tags => [Tag.first_or_create(:text => 'personal')])

    Blog.create(:url => "http://www.bill_gates.tumblr.com",
                :tags => [Tag.first_or_create(:text => 'technology')])

    Blog.create(:url => "http://www.nigella.blogger.com",
                :tags => [Tag.first_or_create(:text => 'cooking')])
  }

  scenario "when opening the home page" do
    visit '/'
    expect(page).to have_link("blog.com")
  end

  scenario "in a clean URL format" do
    visit '/'
    expect(page).to have_link("bill_gates.tumblr.com" && "blog.com" && "nigella.blogger.com")
  end

  scenario "filtered by a tag" do
    visit '/tags/technology'
    expect(page).not_to have_content("blog.com" && "nigella.blogger.com")
    expect(page).to have_link("bill_gates.tumblr.com")
  end

end