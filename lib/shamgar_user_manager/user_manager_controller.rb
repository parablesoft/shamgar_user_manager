require "jsonapi-resources"
require "email_validator"
module ShamgarUserManager
  module UserManagerController

    def self.included(base)
      base.class_eval do
	include JSONAPI::ActsAsResourceController
	class_attribute :resource
      end
    end

    def valid_email
      valid = !resource_klass.exists?(email: params[:email])
      valid = EmailValidator.valid?(params[:email]) if valid
      render json: {is_valid: valid}
    end



    # def resend_confirmation
    # user.send_confirmation_instructions
    # render json: {sent: "OK"}
    # end

    def enable
      resource_klass.only_deleted.find(params[:id]).recover
      # render json: get_json(user,"User",[])
    end


    def resource_klass
      resource || User
    end
  end
end
