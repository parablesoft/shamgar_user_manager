require "email_validator"
module ShamgarUserManager
  module UserManagerController

    def valid_email
      valid = !User.exists?(email: params[:email])
      valid = EmailValidator.valid?(params[:email]) if valid
      render json: {is_valid: valid}
    end
  end
end
