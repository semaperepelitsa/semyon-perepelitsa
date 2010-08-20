class PostSweeper < ActionController::Caching::Sweeper
  observe Post
  
  def before_save(post)
    expire_cache_for post
  end
  
  def after_destroy(post)
    expire_cache_for post
  end
  
  private
  
  def expire_cache_for(post)
    expire_page :controller => 'posts', :action => 'index'
    expire_page :controller => 'posts', :action => 'show', :id => post
  end
end
