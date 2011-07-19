# encoding: UTF-8

Rails.application.routes.draw do
  resources :garages, :only => [:index, :show]
end
