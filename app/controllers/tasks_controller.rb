class TasksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = "新規タスクを作成しました"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @task.destroy
    flash[:success] = "タスクを削除しました"
    # 一つ前のURLにリダイレクト
    redirect_to request.referrer || root_url
  end

  def tasks
    @task_items = current_user.task_list
    @task_items.each do |task|
      task.url = edit_task_path(task)
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

  end

  private 

    def task_params
      params.require(:task).permit(:title, :start, :end)
    end

    def correct_user
      @task = current_user.tasks.find_by(id: params[:id])
      redirect_to root_url if @task.nil?
    end
end
