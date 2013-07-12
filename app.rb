require 'sinatra'

# Uses shotgun for reloading changes
# gem install shotgun
# shotgun -p 4567 shotgun_test.rb

get '/' do
  @foo = 2
	erb :index
end
