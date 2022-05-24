class Organization::Activities::PostsController < Organization::PostsController
  layout 'mypage'

  before_action :set_postable

  private

  def set_postable
    @postable =
      current_user
        .organizations
        .find_by(slug: params[:organization_slug])
        .activities
        .find_by(slug: params[:activity_slug])
  end
end
