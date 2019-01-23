class StaticPagesController < ApplicationController
  def home
    @task = current_user.tasks.build if logged_in?
    @task_items = current_user.task_list.paginate(page: params[:page])
  end

  def help
  end

  def about
  end

  def contact
  end
end
