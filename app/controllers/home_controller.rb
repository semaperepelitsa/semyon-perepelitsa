class HomeController < ApplicationController
  def index
    respond_to do |f|
      f.html { redirect_to posts_path }
      f.xrds do
        xrds = Rails.cache.fetch(:openid_xrds) do
          require 'open-uri'
          open(APP_CONFIG['openid_xrds_url']).read
        end
        render :text => xrds
      end
    end
  end
end
