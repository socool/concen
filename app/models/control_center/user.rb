require "bcrypt"

module ControlCenter
  class User
    include Mongoid::Document
    include Mongoid::Timestamps

    field :full_name, :type => String
    field :username, :type => String
    field :email, :type => String
    field :password_digest, :type => String
    field :full_control, :type => Boolean, :default => false

    attr_reader :password
    attr_accessible :full_name, :username, :email, :password, :password_confirmation

    validates_presence_of :username
    validates_presence_of :email
    validates_presence_of :full_name
    validates_presence_of :password_digest
    validates_uniqueness_of :username, :case_sensitive => false, :allow_blank => true
    validates_uniqueness_of :email, :case_sensitive => false, :allow_blank => true
    validates_length_of :username, :minimum => 3, :maximum => 30, :allow_blank => true
    validates_format_of :username, :with => /^[a-zA-Z0-9_]+$/, :allow_blank => true
    validates_confirmation_of :password
    validates_presence_of :password, :on => :create

    def authenticate(unencrypted_password)
      if BCrypt::Password.new(self.password_digest) == unencrypted_password
        self
      else
        false
      end
    end

    def password=(unencrypted_password)
      @password = unencrypted_password
      unless unencrypted_password.blank?
        self.password_digest = BCrypt::Password.create(unencrypted_password)
      end
    end
  end
end
