class Organization::HotSpringsController < Organization::BaseController
  layout :determine_mypage_layout

  def index
    @hot_springs =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .hot_springs
        .page(params[:page])
        .per(20)
        .with_attached_images
  end

  def show
    @hot_spring =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .hot_springs
        .with_attached_images
        .find_by!(slug: params[:slug])
  end

  def new
    @hot_spring =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .hot_springs
        .build
  end

  def create
    @hot_spring =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .hot_springs
        .build(hot_spring_create_params)

    if @hot_spring.save
      redirect_to organization_hot_springs_path, success: '登録しました'
    else
      flash.now[:error] = '登録に失敗しました'
      render :new
    end
  end

  def edit
    @hot_spring =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .hot_springs
        .with_attached_images
        .find_by(slug: params[:slug])
  end

  def update
    @hot_spring =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .hot_springs
        .find_by!(slug: params[:slug])

    if @hot_spring.update(hot_spring_update_params)
      redirect_to organization_hot_spring_path(
                    @hot_spring.organization,
                    @hot_spring,
                  ),
                  success: '情報を更新しました'
    else
      flash.now[:error] = '情報の更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @hot_spring =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .hot_springs
        .find_by(slug: params[:slug])
    @hot_spring.destroy!
    redirect_to organization_hot_springs_path, success: '削除しました'
  end

  private

  def hot_spring_create_params
    params
      .require(:hot_spring)
      .permit(:name, :lat, :lng, :slug, :description, :address, images: [])
  end

  def hot_spring_update_params
    params
      .require(:hot_spring)
      .permit(:name, :lat, :lng, :description, :address, images: [])
  end
end
