# Setting the omniath logger to the rails logger.
OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :facebook, ENV["KEY"], ENV["SECRET"]
  provider :facebook, "616445941716581", "275dfc115ca83fe951780f11ac09e129"
end
