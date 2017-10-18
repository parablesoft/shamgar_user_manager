class TestController < ActionController::Base
  include Rails.application.routes.url_helpers
end



class UsersController <  ActionController::Base
  include ShamgarUserManager::UserManagerController

end
