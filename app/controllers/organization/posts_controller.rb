class Organization::PostsController < ApplicationController
  def index
    @posts =
      @postable
        .posts
        .with_attached_image
        .page(params[:page])
        .per(20)
        .order(created_at: :desc)
  end

  def new
    @post = @postable.posts.build
  end

  def create
    @post = @postable.posts.build(post_params)
    if @post.save
      redirect_to polymorphic_path(
                    [post.postable.organization, post.postable, :posts],
                  ),
                  success: '登録しました'
    else
      flash.now[:error] = '登録に失敗しました'
      render :new
    end
  end

  def edit
    @post = @postable.posts.find(params[:id])
  end

  def update
    @post = @postable.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to polymorphic_path(
                    [@post.postable.organization, @post.postable, @post],
                  ),
                  success: '投稿を更新しました'
    else
      flash.now[:danger] = '投稿の更新に失敗しました'
      render :edit
    end
  end

  def show
    @post = @postable.posts.find(params[:id])
  end

  def destroy
    @post = @postable.posts.find(params[:id])
    @post.destroy!
    redirect_to polymorphic_path(
                  [@post.postable.organization, @post.postable, :posts],
                ),
                success: '削除しました'
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :status, :image)
  end
end
