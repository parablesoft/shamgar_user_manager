module ShamgarUserManager
  module BaseUser

    def self.included(base)
      base.class_eval do
	validates_presence_of :first_name,:last_name,:email,:role
	acts_as_paranoid
	before_save :ensure_authentication_token
	after_destroy :change_authentication_token!

	scope :unconfirmed, ->{where(confirmed_at: nil)}
	scope :confirmed, ->{where.not(confirmed_at: nil)}
      end
    end

    ROLE_ADMIN = "admin"


    def admin?
      return false if role.nil?
      role.downcase == ROLE_ADMIN
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

    def change_authentication_token!
      update_attributes(authentication_token: generate_authentication_token)
    end

    private 
    def ensure_authentication_token
      self.authentication_token = generate_authentication_token if authentication_token.blank?
    end


    def generate_authentication_token
      loop do
	token = SecureRandom.hex(64)
	break token unless self.class.where(authentication_token: token).first
      end
    end
  end
end
