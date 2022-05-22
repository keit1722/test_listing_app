class Organization::HotelsController < Organization::BaseController
  layout :determine_mypage_layout

  def index
    @hotels =
      current_user
      .organizations
      .find_by!(slug: params[:organization_slug])
      .hotels
      .page(params[:page])
      .per(20)
      .with_attached_images
  end

  def show
    @hotel =
      current_user
      .organizations
      .find_by!(slug: params[:organization_slug])
      .hotels
      .with_attached_images
      .find_by!(slug: params[:slug])
  end

  def new
    @hotel =
      current_user
      .organizations
      .find_by!(slug: params[:organization_slug])
      .hotels
      .build
  end

  def create
    @hotel =
      current_user
      .organizations
      .find_by!(slug: params[:organization_slug])
      .hotels
      .build(hotel_create_params)

    if @hotel.save
      redirect_to organization_hotels_path, success: '登録しました'
    else
      flash.now[:error] = '登録に失敗しました'
      render :new
    end
  end

  def edit
    @hotel =
      current_user
      .organizations
      .find_by!(slug: params[:organization_slug])
      .hotels
      .with_attached_images
      .find_by(slug: params[:slug])
  end

  def update
    @hotel =
      current_user
      .organizations
      .find_by!(slug: params[:organization_slug])
      .hotels
      .find_by!(slug: params[:slug])

    if @hotel.update(hotel_update_params)
      redirect_to organization_hotel_path(@hotel.organization, @hotel),
                  success: '情報を更新しました'
    else
      flash.now[:error] = '情報の更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @hotel =
      current_user
      .organizations
      .find_by!(slug: params[:organization_slug])
      .hotels
      .find_by(slug: params[:slug])
    @hotel.destroy!
    redirect_to organization_hotels_path, success: '削除しました'
  end

  private

  def hotel_create_params
    params
      .require(:hotel)
      .permit(:name, :lat, :lng, :slug, :description, :address, images: [])
  end

  def hotel_update_params
    params
      .require(:hotel)
      .permit(:name, :lat, :lng, :description, :address, images: [])
  end
end
