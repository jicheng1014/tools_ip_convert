# frozen_string_literal: true

require 'sinatra'
require 'sinatra/json'
require_relative './format_location'

get '/' do
  ip = params[:ip]
  json FormatLocation.query(ip).to_h
end
