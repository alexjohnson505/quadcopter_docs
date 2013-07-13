require 'sinatra'
require 'redcarpet'
require "httparty"

views = [:math, :latex]
docs = [:hardware]

get '/' do
  @content = "Home Page"
  erb :index
end

# Match URL to a view
get '/:name' do
  @view = params[:name].to_sym

  if views.include? @view
    erb @view

  elsif docs.include? @view
  	redcarpet = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true)
  	# response = HTTParty.get('/views/hardware.md')

	@content = redcarpet.render(File.read('docs/hardware.md'))
	erb :index

  else
  	@content = @view
    erb :page404
  end
end



