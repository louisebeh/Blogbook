post '/blogs' do
  url = params["url"]
  tags = params["tags"].split(" ").map do |tag|
    Tag.first_or_create(:text => tag)
  end
  Blog.create(:url => url,
              :tags => tags,

              )
  redirect to('/')

  @user = User.create(id: session[:user_id])
  @blogs.users << @user
  @blog.save

end

get '/blogs/new' do
  erb :'blogs/new'
end

