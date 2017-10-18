require 'active_support/all'
require 'action_controller'
require 'action_dispatch'
require "active_record"

module Rails
  class App
    def env_config; {} end
    def routes
      return @routes if defined?(@routes)
      @routes = ActionDispatch::Routing::RouteSet.new
      @routes.draw do
	resources :users do 
	  collection do
	    post :valid_email
	  end
	end
      end
      @routes
    end
  end

  def self.application
    @app ||= App.new
  end
end
