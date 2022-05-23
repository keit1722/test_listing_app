class BookmarksController < ApplicationController
  def create
    current_user.bookmark(@bookmarkable)
  end

  def destroy
    current_user.unbookmark(@bookmarkable)
  end
end
