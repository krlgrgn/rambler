class User < ActiveRecord::Base
  attr_accessible :about, :city, :country, :email,
                  :first_name, :last_name, :state

  # Validations
  validates :email,      presence: true, uniqueness: true,
                         format: {
                                   with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/,
                                   message: "Invalid emaill address."
                         }
  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :city,       presence: true
  validates :state,      presence: true
  validates :about,      presence: false
  validates :country,    presence: true

end
