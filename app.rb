require 'sinatra/base'
require 'sinatra/reloader'
require 'sass'

require_relative 'lib/maptool.rb'

# Parse Sass styles
class SassHandler < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/views/stylesheets'

  get '/css/*.css' do
    filename = params[:splat].first
    scss filename.to_sym
  end
end

# The routes
class MyApp < Sinatra::Base
  use SassHandler

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    slim :index, locals: { map_tool: nil }
  end

  post '/generate' do
    cols = (params[:columns] || 10).to_i
    rows = (params[:rows] || 10).to_i
    empty_weight = (params[:empty_probability] || 0.02).to_i
    precision = (params[:precicion] || 2).to_i
    precision = 14 if precision > 14
    precision = 2 if precision < 2
    print_border = params[:print_border] || true

    map_tool = Maptool.new(cols, rows, empty_weight, precision, print_border)
    map_tool.run!

    slim :index, locals: { map_tool: map_tool }
  end
end

MyApp.run! port: 4567 if $PROGRAM_NAME == __FILE__
