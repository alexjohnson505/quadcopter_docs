require 'sinatra'

views = [:page1, :page2]

get '/' do
  @page_name = "Home"
	erb :index
end

get '/:name' do
  @view = params[:name].to_sym

  if views.include? @view
    erb @view
  else
    erb :page404
  end
end