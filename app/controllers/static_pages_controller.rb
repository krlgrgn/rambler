class StaticPagesController < ApplicationController
  before_filter :redirect_to_root
  # GET /home
  def home
  end

  # GET /help
  def help
  end
end
