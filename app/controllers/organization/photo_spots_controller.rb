class Organization::PhotoSpotsController < Organization::BaseController
  layout :determine_mypage_layout

  def index
    @photo_spots =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .photo_spots
        .page(params[:page])
        .per(20)
        .with_attached_images
  end

  def show
    @photo_spot =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .photo_spots
        .with_attached_images
        .find_by!(slug: params[:slug])
  end

  def new
    @photo_spot =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .photo_spots
        .build

    @districts = District.all
  end

  def create
    @photo_spot =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .photo_spots
        .build(photo_spot_create_params)

    @districts = District.all

    if @photo_spot.save
      redirect_to organization_photo_spots_path, success: '登録しました'
    else
      flash.now[:error] = '登録に失敗しました'
      render :new
    end
  end

  def edit
    @photo_spot =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .photo_spots
        .with_attached_images
        .find_by(slug: params[:slug])

    @districts = District.all
  end

  def update
    @photo_spot =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .photo_spots
        .with_attached_images
        .find_by!(slug: params[:slug])

    @districts = District.all

    if @photo_spot.update(photo_spot_update_params)
      redirect_to organization_photo_spot_path(
                    @photo_spot.organization,
                    @photo_spot,
                  ),
                  success: '情報を更新しました'
    else
      flash.now[:error] = '情報の更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @photo_spot =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .photo_spots
        .find_by(slug: params[:slug])
    @photo_spot.destroy!
    redirect_to organization_photo_spots_path, success: '削除しました'
  end

  private

  def photo_spot_create_params
    params
      .require(:photo_spot)
      .permit(
        :name,
        :lat,
        :lng,
        :slug,
        :description,
        :address,
        :district_ids,
        images: [],
      )
  end

  def photo_spot_update_params
    params
      .require(:photo_spot)
      .permit(
        :name,
        :lat,
        :lng,
        :description,
        :address,
        :district_ids,
        images: [],
      )
  end
end
