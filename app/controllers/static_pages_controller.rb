class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @task = current_user.tasks.build
      @task_items = current_user.tasks.all
      @task_items.each do |task|
        task.url = edit_task_path(task)
      end
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
