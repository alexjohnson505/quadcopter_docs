require 'sinatra'
require 'httparty'
require 'redcarpet'

# Page list
views = [:index, :videos]  # Allowed views
docs = Dir['docs/**/*.md'] # All markdown files in docs/

# Chop off any trailing slashes. This will make the two routes,
# '/foo/bar' and '/foo/bar/' equivalent in the eyes of both the
# user and our application.
#
# This means it is __CRITITCAL__ that no routes be specified with
# trailing slashes, as they will never ever ever be hit.
before { request.path_info.sub! %r{/$}, '' }

get '/' do
  @content = "Welcome to the Home Page"
  erb :index
end

# Index page for the docs. Users can start to navigate the docs
# from here. Furthermore, this will be a fantastic place to link
# directly to, so consider it almost a landing page.
get '/docs' do
  erb :docs, :locals => { :docs => docs }
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
