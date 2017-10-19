module ShamgarUserManager
  module BaseUser

    def self.included(base)
      base.class_eval do
	validates_presence_of :first_name,:last_name,:email,:role
	acts_as_paranoid
	before_save :ensure_authentication_token!
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

    def unconfirmed?
      !confirmed?
    end

    def disabled?
      deleted?
    end

    def change_authentication_token!
      update_attributes(authentication_token: generate_token(:authentication))
    end

    def method_missing(method)
      method = method.to_s
      return nil unless method.starts_with?("ensure") && method.ends_with?("token!")
      token_name = /ensure_(.+)_token!/.match(method)[1]
      ensure_token!(token_name)
    end

    private 
    def ensure_token!(token_name)
      field_name = "#{token_name}_token"
      self[field_name] = generate_token(token_name.to_sym) if self[field_name].blank?
    end

    def generate_token(token_name)
      loop do
	token = SecureRandom.hex(100)
	break token unless self.class.where("#{token_name}_token" => token).first
      end
    end

  end
end
