require 'sinatra'
require 'redcarpet'
require "httparty"

# Page list
views = [:index, :videos]  # Allowed views
docs = Dir['docs/**/*.md'] # All markdown files in docs/

get '/' do
  @content = "Welcome to the Home Page"
  erb :index
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
    @content = @view + " Requested docs file not found"
    erb :index
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
    @content = @view + " Requested docs file not found"
    erb :index
  end
end

# Match URL to a view
get '/:name' do
  @view = params[:name].to_sym

  if views.include? @view
    erb @view

  else
    erb :page404
  end
end
