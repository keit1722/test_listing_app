class Organization::SkiAreasController < Organization::BaseController
  layout :determine_mypage_layout

  def index
    @ski_areas =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .ski_areas
        .page(params[:page])
        .per(20)
        .with_attached_images
  end

  def show
    @ski_area =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .ski_areas
        .with_attached_images
        .find_by!(slug: params[:slug])
  end

  def new
    @ski_area =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .ski_areas
        .build

    @districts = District.all
  end

  def create
    @ski_area =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .ski_areas
        .build(ski_area_create_params)

    @districts = District.all

    if @ski_area.save
      redirect_to organization_ski_areas_path, success: '登録しました'
    else
      flash.now[:error] = '登録に失敗しました'
      render :new
    end
  end

  def edit
    @ski_area =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .ski_areas
        .with_attached_images
        .find_by(slug: params[:slug])

    @districts = District.all
  end

  def update
    @ski_area =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .ski_areas
        .with_attached_images
        .find_by!(slug: params[:slug])

    @districts = District.all

    if @ski_area.update(ski_area_update_params)
      redirect_to organization_ski_area_path(@ski_area.organization, @ski_area),
                  success: '情報を更新しました'
    else
      flash.now[:error] = '情報の更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @ski_area =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .ski_areas
        .find_by(slug: params[:slug])
    @ski_area.destroy!
    redirect_to organization_ski_areas_path, success: '削除しました'
  end

  private

  def ski_area_create_params
    params
      .require(:ski_area)
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

  def ski_area_update_params
    params
      .require(:ski_area)
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
