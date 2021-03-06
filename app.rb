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
    slim :index, locals: {
      map_tool: nil,
      params: {
        columns: 10,
        rows: 10,
        empty_probability: 0.02,
        precision: 2,
        print_border: false
      }
    }
  end

  post '/generate' do
    cols = (params[:columns] || 10).to_i
    rows = (params[:rows] || 10).to_i
    empty_weight = (params[:empty_probability] || 0.02).to_i
    precision = (params[:precision] || 2).to_i
    precision = 14 if precision > 14
    precision = 2 if precision < 2
    print_border = params[:print_border] == 'on' || false

    map_tool = Maptool.new(cols, rows, empty_weight, precision, print_border)
    map_tool.run!

    slim :index, locals: { map_tool: map_tool, params: params }
  end
end

MyApp.run! port: 4567, bind: "0.0.0.0" if $PROGRAM_NAME == __FILE__
