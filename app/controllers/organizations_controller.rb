class OrganizationsController < ApplicationController
  before_action :require_login
  before_action :only_business

  def index
    @organizations = current_user.organizations
  end

  def new
    @organization = current_user.organizations.build
  end

  def create
    @organization = current_user.organizations.new(organization_new_params)
    if @organization.save
      redirect_to organizations_path, success: '組織を作成しました'
    else
      flash.now[:danger] = '組織を作成できませんでした'
      render :new
    end
  end

  def edit
    @organization = current_user.organizations.find_by!(slug: params[:slug])
  end

  def update
    @organization = current_user.organizations.find_by!(slug: params[:slug])
    if @organization.update(organization_edit_paramas)
      redirect_to organization_path, success: '組織の情報を更新しました'
    else
      flash.now[:error] = '組織の情報を更新できませんでした'
      render :edit
    end
  end

  def show
    @organization = current_user.organizations.find_by!(slug: params[:slug])
  end

  def destroy
    @organization = current_user.organizations.find_by!(slug: params[:slug])
    @organization.destroy!
    redirect_to organizations_path, success: '組織を削除しました'
  end

  private

  def organization_new_params
    params.require(:organization).permit(:name, :address, :phone, :slug)
  end

  def organization_edit_params
    params.require(:organization).permit(:name, :address, :phone)
  end

  def only_business
    redirect_to root_path unless current_user.business?
  end
end
