require "email_validator"
module ShamgarUserManager
  module UserManagerController

    def valid_email
      valid = !User.exists?(email: params[:email])
      valid = EmailValidator.valid?(params[:email]) if valid
      render json: {is_valid: valid}
    end



    # def resend_confirmation
    # user.send_confirmation_instructions
    # render json: {sent: "OK"}
    # end

    # def enable
    #   User.only_deleted.find(params[:id]).recover
    #   render json: get_json(user,"User",[])
    # end
  end
end
