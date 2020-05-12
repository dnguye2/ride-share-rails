class HomepagesController < ApplicationController
  def index
  end

  def show
    render template: "homepages/#{params[:page]}"
  end
end
