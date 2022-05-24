class Mypage::BookmarksController < Mypage::BaseController
  def index
    @bookmarks =
      current_user
        .bookmarks
        .includes([:bookmarkable])
        .page(params[:page])
        .per(20)
        .order(created_at: :desc)
  end
end
