require 'active_support/all'
require 'action_controller'
require 'action_dispatch'
require "active_record"
require 'acts_as_paranoid'
require "shamgar_user_manager/routing"

module Rails
  class App
    def env_config; {} end
    def routes
      return @routes if defined?(@routes)
      @routes = ActionDispatch::Routing::RouteSet.new
      @routes.draw do
	user_manager_for(:users,:resources)
      end
      @routes
    end
  end

  def self.application
    @app ||= App.new
  end
end
