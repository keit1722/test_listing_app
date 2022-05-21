class Organization::ShopsController < Organization::BaseController
  layout :determine_layout

  def index
    @shops =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .shops
  end

  def show
    @shop =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .shops
        .find_by!(slug: params[:slug])
  end

  def new
    @shop =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .shops
        .build
  end

  def create
    @shop =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .shops
        .build(shop_create_params)
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
        .find_by(slug: params[:slug])
  end

  def update
    @shop =
      current_user
        .organizations
        .find_by!(slug: params[:organization_slug])
        .shops
        .find_by!(slug: params[:slug])
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
      .permit(:name, :lat, :lng, :slug, :description, :address)
  end

  def shop_update_params
    params.require(:shop).permit(:name, :lat, :lng, :description, :address)
  end
end
