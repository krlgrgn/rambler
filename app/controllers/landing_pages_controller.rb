class LandingPagesController < ApplicationController
  # GET /landing_pages/new
  # GET /landing_pages/new.json
  def new
    @landing_page = LandingPage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @landing_page }
    end
  end

  # POST /landing_pages
  # POST /landing_pages.json
  def create
    @landing_page = LandingPage.new(params[:landing_page])

    respond_to do |format|
      if @landing_page.save
        @landing_page.send_register_interest_email
        format.html { redirect_to root_path, notice: 'Thank you for expressing your interest.' }
        format.json { render json: root_path, status: :created, location: root_path }
      else
        format.html { redirect_to root_path }
        format.json { render json: root_path, status: :unprocessable_entity }
      end
    end
  end
end
