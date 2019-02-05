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
    # グループ作成者は自動的に当該グループに所属する
    @group.users << current_user
    # 作成者はownerとして登録される
    @group.owner_id = current_user.id
    if @group.save
      flash[:success] = "新規グループを作成しました"
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

  def join
    @group = Group.find(params[:id])
    # グループに所属していなければ追加
    unless @group.users.include?(current_user)
      flash[:success] = "「#{@group.name}」に参加しました"
      @group.users << current_user
    else
      flash[:danger] = "あなたはすでに「#{@group.name}」のメンバーです"
    end
    redirect_to group_url
  end

  def defection
    @group = Group.find(params[:id])
    # 作成者じゃなく、かつグループに参加していれば退会
    if @group.owner_id == current_user.id
      flash[:danger] = "あなたはこのグループの作成者のため、退会する場合はグループ自体を削除して下さい"
      render 'show'
    elsif @group.users.include?(current_user)
      flash[:success] = "#{@group.name}グループから退会しました"
      @group.group_users.find_by(user_id: current_user).destroy
      redirect_to groups_url
    end
  end

  def destroy
    @group = Group.find(params[:id])
    group_name = @group.name
    @group.destroy
    flash[:success] = "「#{group_name}」グループを削除しました"
    redirect_to groups_url
  end

  private

    def group_params
      params.require(:group).permit(:name)
    end

    def owner
      @group = Group.find(params[:id])
      unless @group.owner_id == current_user.id
        flash[:danger] = "グループの編集／削除は作成者のみが行えます"
        redirect_to @group
      end
    end
end