class Organization::RestaurantsController < Organization::BaseController
  layout :determine_mypage_layout

  def index
    @restaurants =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .restaurants
        .page(params[:page])
        .per(20)
        .with_attached_images
  end

  def show
    @restaurant =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .restaurants
        .with_attached_images
        .find_by!(slug: params[:slug])
  end

  def new
    @restaurant =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .restaurants
        .build
    @restaurant_categories = RestaurantCategory.all
  end

  def create
    @restaurant =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .restaurants
        .build(restaurant_create_params)

    @restaurant_categories = RestaurantCategory.all
    if @restaurant.save
      redirect_to organization_restaurants_path, success: '登録しました'
    else
      flash.now[:error] = '登録に失敗しました'
      render :new
    end
  end

  def edit
    @restaurant =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .restaurants
        .with_attached_images
        .find_by(slug: params[:slug])
    @restaurant_categories = RestaurantCategory.all
  end

  def update
    @restaurant =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .restaurants
        .find_by!(slug: params[:slug])
    @restaurant_categories = RestaurantCategory.all

    if @restaurant.update(restaurant_update_params)
      redirect_to organization_restaurant_path(
                    @restaurant.organization,
                    @restaurant,
                  ),
                  success: '情報を更新しました'
    else
      flash.now[:error] = '情報の更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @restaurant =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .restaurants
        .find_by(slug: params[:slug])
    @restaurant.destroy!
    redirect_to organization_restaurants_path, success: '削除しました'
  end

  private

  def restaurant_create_params
    params
      .require(:restaurant)
      .permit(
        :name,
        :lat,
        :lng,
        :slug,
        :description,
        :address,
        images: [],
        restaurant_category_ids: [],
      )
  end

  def restaurant_update_params
    params
      .require(:restaurant)
      .permit(
        :name,
        :lat,
        :lng,
        :description,
        :address,
        images: [],
        restaurant_category_ids: [],
      )
  end
end
