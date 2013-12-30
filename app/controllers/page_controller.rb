class PageController < ApplicationController
  def index
  end

  def directory
    @users = User.all
  end

  def events
  end

  def contact
  end
end