class TasksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  before_action :owner, only: [:edit, :update, :destroy]

  def show
    @task = current_user.tasks.find_by(id: params[:id])
  end

  def create
    # @task = current_user.tasks.build(task_params)
    # if @task.save
    #   flash[:success] = "新規予定を作成しました"
    #   redirect_to root_url
    # else
    #   render 'static_pages/home'
    # end
    @task = Task.new(task_params)
    @groups = Group.all
    params.require(:task).permit(users: [])
    users = params[:task][:users]
    # unless users.nil?
    #   users.uniq!
    #   if users.uniq!
    #     users.uniq!.each do |user_id|
    #       @task.users << User.find_by(id: user_id)
    #     end
    #   else
    #     users.each do |user_id|
    #       @task.users << User.find_by(id: user_id)
    #     end
    #   end
    # end
    unless users.nil?
      users.uniq!
      users.each do |user_id|
        @task.users << User.find_by(id: user_id)
      end

    end
    # グループ作成者は自動的に当該グループに所属する
    @task.users << current_user
    
    # 作成者はownerとして登録される
    @task.owner_id = current_user.id
    if @task.save
      flash[:success] = "新規予定を作成しました"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
    # @task.destroy
    # flash[:success] = "予定を削除しました"
    # # 一つ前のURLにリダイレクト
    # redirect_to root_url
    @task = Task.find(params[:id])
    @task.destroy
    flash[:success] = "予定を削除しました"
    redirect_to root_url
  end

  def tasks
    # @task_items = current_user.task_list
    # @task_items.each do |task|
    #   task.url = edit_task_path(task)
    # end
    # # JSONの出力
    # respond_to do |format|
    #   format.json {
    #     render json:
    #     @task_items.to_json(methods: :url)
    #   }
    # end
    @task_items = current_user.tasks.all
    @task_items.each do |task|
      task.url = task_path(task)
    end
    # JSONの出力
    respond_to do |format|
      format.json {
        render json:
        @task_items.to_json(methods: :url)
      }
    end
  end

  def edit
    @task = current_user.tasks.find_by(id: params[:id])
  end

  def update
    @task = current_user.tasks.find_by(id: params[:id])
    @groups = Group.all
    params.require(:task).permit(users: [])
    users = params[:task][:users]

    @task.users = []
    unless users.nil?
      users.uniq!
      users.each do |user_id|
        @task.users << User.find_by(id: user_id)
      end
    end
    @task.users << current_user
    
    @task.owner_id = current_user.id
    if @task.save
      flash[:success] = "予定を更新しました"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  private 

    def task_params
      params.require(:task).permit(:title, :start, :end)
    end

    def correct_user
      @task = current_user.tasks.find_by(id: params[:id])
      redirect_to root_url if @task.nil?
    end

    def owner
      @task = Task.find(params[:id])
      unless @task.owner_id == current_user.id
        flash[:danger] = "予定の編集／削除は作成者のみが行えます"
        redirect_to @task
      end
    end
end
