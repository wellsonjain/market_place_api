Rails.application.routes.draw do
  # API defination
  namespace :api, default: {type: :json}, constraints: {subdomain: 'api'}, path: '/' do
  end
end
