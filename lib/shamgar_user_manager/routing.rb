class ActionDispatch::Routing::Mapper
  def user_manager_for(route,route_method)
    send(route_method, route, only: [:index,:show,:create,:update,:destroy]) do
      collection do
	post :valid_email
      end
      member do
	post :resend_confirmation
	post :enable
      end
    end
  end
end
