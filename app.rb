require 'bundler/setup'
Bundler.require(:default)

# Fix load path
$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'quadrocopter_docs'
documentation = QuadrocopterDocs::Documentation.new

# Page list
views = [:index, :videos, :docs]  # Allowed views

# Chop off any trailing slashes. This will make the two routes,
# '/foo/bar' and '/foo/bar/' equivalent in the eyes of both the
# user and our application.
#
# This means it is __CRITITCAL__ that no routes be specified with
# trailing slashes, as they will never ever ever be hit.
before { request.path_info.sub! %r{/$}, '' }

get '/' do
  erb "Welcome to the Home Page"
end

# 404 Not Found
get '/404' do
  erb :'404'
end

# Documentation
get '/docs/*' do
  path = 'docs/' + params[:splat][0] + '.md'

  if documentation.contains(path)
    erb documentation.render(path)
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
