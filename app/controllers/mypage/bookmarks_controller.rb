class Mypage::BookmarksController < Mypage::BaseController
  def index
    @bookmarks =
      Bookmark
        .includes([:bookmarkable])
        .page(params[:page])
        .per(5)
        .order(created_at: :desc)
  end
end
