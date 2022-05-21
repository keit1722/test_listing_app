class Organization::ShopsController < Organization::BaseController
  layout :determine_layout

  def index
    @shops =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .shops
        .page(params[:page])
        .per(20)
        .with_attached_images
  end

  def show
    @shop =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .shops
        .with_attached_images
        .find_by!(slug: params[:slug])
  end

  def new
    @shop =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .shops
        .build
    @shop_categories = ShopCategory.all
  end

  def create
    @shop =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .shops
        .build(shop_create_params)

    @shop_categories = ShopCategory.all
    if @shop.save
      redirect_to organization_shops_path, success: '登録しました'
    else
      flash.now[:error] = '登録に失敗しました'
      render :new
    end
  end

  def edit
    @shop =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .shops
        .with_attached_images
        .find_by(slug: params[:slug])
    @shop_categories = ShopCategory.all
  end

  def update
    @shop =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .shops
        .find_by!(slug: params[:slug])
    @shop_categories = ShopCategory.all

    if @shop.update(shop_update_params)
      redirect_to organization_shop_path(@shop.organization, @shop),
                  success: '情報を更新しました'
    else
      flash.now[:error] = '情報の更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @shop =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .shops
        .find_by(slug: params[:slug])
    @shop.destroy!
    redirect_to organization_shops_path, success: '削除しました'
  end

  private

  def shop_create_params
    params
      .require(:shop)
      .permit(
        :name,
        :lat,
        :lng,
        :slug,
        :description,
        :address,
        images: [],
        shop_category_ids: [],
      )
  end

  def shop_update_params
    params
      .require(:shop)
      .permit(
        :name,
        :lat,
        :lng,
        :description,
        :address,
        images: [],
        shop_category_ids: [],
      )
  end
end
