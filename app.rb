require 'sinatra'

views = [:math, :latex]

get '/' do
  @page_name = "Home"
	erb :index
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