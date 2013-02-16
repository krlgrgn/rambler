class User < ActiveRecord::Base
  attr_accessible :about, :city, :country, :email,
                  :first_name, :last_name, :state,
                  :password, :password_confirmation

  # Validations
  validates :email,      presence: true, uniqueness: true,
                         format: {
                                   with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/,
                                   message: "Invalid emaill address."
                         }
  validates :first_name,            presence: true
  validates :last_name,             presence: true
  validates :city,                  presence: true
  validates :state,                 presence: true
  validates :country,               presence: true
  validates :about,                 presence: false, allow_blank: true
  validates :password,              presence: true,  length: { minimum: 6 }
  validates :password_confirmation, presence: true

  # Filters
  before_save { |user| user.email = email.downcase }

  # methods
  has_secure_password
end
