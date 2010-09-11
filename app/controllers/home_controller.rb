class HomeController < ApplicationController
  def index
    respond_to do |f|
      f.html { redirect_to posts_path }
    end
  end
end
