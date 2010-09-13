class HomeController < ApplicationController
  def index
    respond_to do |f|
      f.html { redirect_to posts_path }
      f.xrds do
        render :text => Rails.cache.fetch(:openid_xrds) do
          require 'open-uri'
          open(APP_CONFIG['openid_xrds_url']).read
        end
      end
    end
  end
end
