require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/posts/new' do
    erb :'/posts/new'
  end

  post '/posts' do
    @post = Post.new
    @post.name = params[:name]
    @post.content = params[:content]
    @post.save
    redirect '/posts'
  end

  get '/posts' do
    @posts = Post.all
    erb :'/posts/index'
  end

  get '/posts/:id' do
    @post = Post.find(params[:id])
    erb :'/posts/show'
  end

  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    erb :'/posts/edit'
  end

  patch '/posts/:id' do
    @post = Post.find(params[:id])
    @post.name = params[:name]
    @post.content = params[:content]
    @post.save
    redirect "/posts/#{@post.id}"
  end

  delete '/posts/:id' do
    @post = Post.find(params[:id])
    Post.destroy(@post.id)
    # binding.pry
    erb :"/posts/delete"
  end

end


  # The Read CRUD action corresponds to two different controller
  # actions: show and index. The show action should render the erb
  # view show.erb, which shows an individual post. The index
  # action should render the erb view index.erb, which shows a
  # list of all of the posts. Create the get '/posts' controller
  # action. This action should use Active Record to grab all of
  # the posts and store them in an instance variable, @posts.
  # Then, it should render the index.erb view. That view should
  # use erb to iterate over @posts and render them on the page.
  # Create the get '/posts/:id' controller action. This action
  # should use Active Record to grab the post with the id that
  # is in the params and set it equal to @post. Then, it should
  # render the show.erb view page. That view should use erb to
  # render the @post's title and content.
