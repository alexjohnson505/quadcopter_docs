require 'bundler/setup'
Bundler.require(:default)

# Fix load path
$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'quadrocopter_docs'
documentation = QuadrocopterDocs::Documentation.new

# Page list
views = [:index, :videos]  # Allowed views

# Home
get '/' do
  @content = "Welcome to the Home Page"
  erb :index
end

# 404 Not Found
get '/404' do
  erb :'404'
end

# Documentation
get '/docs/*' do
  path = 'docs/' + params[:splat][0] + '.md'

  if documentation.contains(path)
    @content = documentation.render(path)
    erb :index
  else
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
