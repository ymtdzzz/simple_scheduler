class GroupsController < ApplicationController
  before_action :owner, only: [:edit, :update, :destroy]

  def index
    @groups = Group.paginate(page: params[:page])
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:success] = "新規グループを作成しました"
      # グループ作成者は自動的に当該グループに所属する
      @group.users << current_user
      # 作成者はownerとして登録される
      @group.owner_id = current_user.id
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(group_params)
      flash[:success] = "グループ情報を更新しました"
      redirect_to @group
    else
      render 'edit'
    end
  end

  def destroy
  end

  private

    def group_params
      params.require(:group).permit(:name)
    end

    def owner
      @group = Group.find(params[:id])
      flash[:danger] = "グループの編集／削除は作成者のみが行えます"
      redirect_to @group unless @group.owner_id == current_user.id        
    end
end
