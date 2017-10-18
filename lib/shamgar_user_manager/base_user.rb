
module ShamgarUserManager
  module BaseUser


    def self.included(base)
      base.class_eval do
	acts_as_paranoid
      end
    end


    def full_name
      "#{first_name} #{last_name}"
    end


    def confirmed?
      confirmed_at.present?
    end


    def disabled?
      deleted?
    end
  end
end
