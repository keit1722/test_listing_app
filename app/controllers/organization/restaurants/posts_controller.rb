class Organization::Restaurants::PostsController < Organization::PostsController
  layout 'mypage'

  before_action :set_postable

  private

  def set_postable
    @postable =
      current_user
        .organizations
        .find_by(slug: params[:organization_slug])
        .restaurants
        .find_by(slug: params[:restaurant_slug])
  end
end
