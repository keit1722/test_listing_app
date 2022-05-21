class Organization::ActivitiesController < Organization::BaseController
  layout :determine_mypage_layout

  def index
    @activities =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .activities
        .page(params[:page])
        .per(20)
        .with_attached_images
  end

  def show
    @activity =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .activities
        .with_attached_images
        .find_by!(slug: params[:slug])
  end

  def new
    @activity =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .activities
        .build
  end

  def create
    @activity =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .activities
        .build(activity_create_params)

    if @activity.save
      redirect_to organization_activities_path, success: '登録しました'
    else
      flash.now[:error] = '登録に失敗しました'
      render :new
    end
  end

  def edit
    @activity =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .activities
        .with_attached_images
        .find_by(slug: params[:slug])
  end

  def update
    @activity =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .activities
        .find_by!(slug: params[:slug])

    if @activity.update(activity_update_params)
      redirect_to organization_activity_path(@activity.organization, @activity),
                  success: '情報を更新しました'
    else
      flash.now[:error] = '情報の更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @activity =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .activitys
        .find_by(slug: params[:slug])
    @activity.destroy!
    redirect_to organization_activities_path, success: '削除しました'
  end

  private

  def activity_create_params
    params
      .require(:activity)
      .permit(:name, :lat, :lng, :slug, :description, :address, images: [])
  end

  def activity_update_params
    params
      .require(:activity)
      .permit(:name, :lat, :lng, :description, :address, images: [])
  end
end
