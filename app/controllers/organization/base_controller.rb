class Organization::BaseController < ApplicationController
  before_action :require_login
  before_action :only_business

  def determine_mypage_layout
    action_name == 'index' ? 'mypage' : 'mypage_maps'
  end
end
