class GroupsController < ApplicationController
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
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def group_params
      params.require(:group).permit(:name)
    end
end
