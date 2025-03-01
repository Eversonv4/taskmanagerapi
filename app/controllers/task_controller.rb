class TaskController < ApplicationController
  before_action :set_user, :authenticate

  def index
    if @user.task
      render json: @user.task, status: :ok
    else
      render json: { error: "Nenhuma tarefa encontrada" }, status: :not_found
    end
  end

  def create
    body = params[:body]
    last_synchronization = params[:last_synchronization]

    @task = Task.create(
      user_id: @user.id,
      body: body,
      last_synchronization: last_synchronization
    )

    if @task.save
      render json: @user.task, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    @task = @user.task

    if @task.update(task_params)
      render json: @task, status: :ok
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  private

    def set_user
      auth_header = request.headers["Authorization"]

      if auth_header.present? && auth_header.starts_with?("Bearer ")
        token = auth_header.split(" ").last
        @user = Session.find_signed(token).user
      else
        render json: { error: "Token inválido ou ausente" }, status: :unauthorized
      end
    end

    def task_params
      params.permit(:body, :last_synchronization)
    end
end
