class SpecialController < ApplicationController
  skip_before_filter :authenticate_user!
  layout nil 

  def user_utils
    if user_signed_in?
      @clipboard_clippings = Clipping.scoped(:conditions => {:folder_id => nil, :user_id => current_user.id}).with_preloaded_articles || []
      @folders = FolderDecorator.decorate( Folder.scoped(:conditions => {:creator_id => current_user.model}).all )
    elsif cookies[:document_numbers].present?
      @clipboard_clippings = Clipping.all_preloaded_from_cookie( cookies[:document_numbers] ) || []
      @folders   = []
    else
      cache_for 1.day
      @clipboard_clippings = []
      @folders = []
    end
  end

  def navigation
    cache_for 1.day
  end

  def shared_assets
    cache_for 1.day
  end
end
