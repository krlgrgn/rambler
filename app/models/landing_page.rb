class LandingPage < ActiveRecord::Base
  attr_accessible :email

  EMAIL_REGEXP = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/

  # Validations
  validates :email,      presence: true, uniqueness: {
                           message: "You have already expressed your interest."
                         },
                         format: {
                            with: EMAIL_REGEXP,
                            message: "Invalid email address."
                         }

  # Methods
  def send_register_interest_email
    UserMailer.register_interest(self).deliver
  end
end
