class User < ActiveRecord::Base
  attr_accessible :about, :city, :country, :email, :first_name, :last_name,
                  :state, :password, :password_confirmation, :session_token

  EMAIL_REGEXP = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/


  # Validations
  validates :email,      presence: true, uniqueness: true,
                         format: {
                            with: EMAIL_REGEXP,
                            message: "Invalid email address."
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
  before_save :create_session_token

  # Relations
  has_many :adventures

  # Methods
  has_secure_password

  #
  #  We are using the ActiveSupport MessageVerifier to
  #  genearte a unique encrypted self expiring token based on the user's
  #  encrypted password (i.e. it's the salt)
  #
  #  The token is set to expire in 1 day from the time for creation.
  #
  def send_password_reset_email
    token = ActiveSupport::MessageVerifier.new(
      Rails.configuration.secret_token).generate(
        [id,1.day.from_now,password_digest])

    UserMailer.reset_password(self, token).deliver
  end

  #
  # This method searches for the user by its password reset token.
  # Whne the token is generated (in the method above) it uses the users id
  # to generate it, and when we verify it we can extract the id, then use it
  # to retrieve the user object.
  #
  def self.find_by_password_reset_token(token)
    user_id, expiration = ActiveSupport::MessageVerifier.new(
      Rails.configuration.secret_token).verify(token)

    if expiration.future?
      User.find(user_id)
    else
      nil
    end
  end

  # Private methods
  private
    def create_session_token
      self.session_token = SecureRandom.urlsafe_base64
    end
end
