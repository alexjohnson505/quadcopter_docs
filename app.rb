require 'bundler/setup'
Bundler.require(:default)

$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'quadrocopter_docs'

# Page list
views = [:index, :videos]  # Allowed views
docs = Dir['docs/**/*.md'] # All markdown files in docs/

get '/' do
  @content = "Welcome to the Home Page"
  erb :index
end

# 404 Not Found :(
# This is the route users will be rediected to when they attempt
# to go somewhere that doesn't exist.
get '/404' do
  erb :'404'
end

# Find in Docs
get '/docs/:name' do
  # Build file URL
  @view = 'docs/' + params[:name] + '.md'

  if docs.include? @view
    @content = "hello"
    redcarpet = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true)
    @content = redcarpet.render(File.read(@view))
    erb :index
  elsif
    redirect '/404'
  end
end

# TODO: Simplify this logic into previous function
# Find in Docs subdirectory
get '/docs/*/:name' do
  # Build file URL
  @view = 'docs/' + params[:splat][0] + "/" + params[:name] + '.md'

  if docs.include? @view
    @content = "hello"
    redcarpet = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true)
    @content = redcarpet.render(File.read(@view))
    erb :index
  elsif
    redirect '/404'
  end
end

# Match URL to a view
get '/:name' do
  @view = params[:name].to_sym

  if views.include? @view
    erb @view

  else
    redirect '/404'
  end
end
