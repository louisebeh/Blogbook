require 'spec_helper'

feature "User adds a new link" do

  scenario "when browsing the homepage" do
    expect(Blog.count).to eq(0)
    visit '/'
    add_blog("http://www.blog.com/", "My blog")
    expect(Blog.count).to eq(1)
    blog = Blog.first
    expect(blog.url).to eq("http://www.blog.com/")
    expect(blog.title).to eq("My blog")
  end

  scenario "with a few tags" do
    visit "/"
    add_blog("http://www.blog.com/",
                "My blog",
                ['personal', 'ruby'])
    blog = Blog.first
    expect(blog.tags.map(&:text)).to include "personal", "ruby"
  end


  def add_blog(url, title, tags = [])
    within('#new-blog') do
      fill_in 'url', :with => url
      fill_in 'title', :with => title
      fill_in 'tags', :with => tags.join(' ')
      click_button 'Add blog'
    end
  end
end