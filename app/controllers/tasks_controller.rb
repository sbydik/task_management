class TasksController < ApplicationController
  before_action :sanitize_task_params, only: [:create, :update]
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # タスク一覧画面
  # GET /tasks
  def index
    # 検索項目が入力されていた場合
    if !search_form_params.to_query.empty?
      @search_form = SearchForm.new(search_form_params)
      @tasks = @search_form.search
    else
      @tasks = Task.all
      @search_form = SearchForm.new
    end

    # ステータス一括更新時に、検索条件を引き継ぐためにテンプレートにセットする
    @search_queries = search_form_params.to_query
  end

  # タスクのステータス一括更新処理
  # POST /update_task_status
  def update_task_status
    if update_task_status_params[:status]
      update_task_status_params[:status].each do |task_id, status|
        permit_task_ids = {}
        # 定義されていないステータスは、除く
        if Task.statuses.values.include?(status.to_i)
          Task.where(id: task_id.to_i).update(status: status.to_i)        
        end
      end
      notice = "タスクの状態の更新に成功しました！"
    end

    respond_to do |format|
      format.html {
        # 検索条件のクエリを引き継ぐ
        redirect_to "#{tasks_url}?#{update_task_status_params[:search_queries]}", 
        notice: notice
      }
      format.json { head :no_content }
    end
  end

  # タスク登録画面
  # GET /tasks/new
  def new
    @task = Task.new
  end

  # タスク更新画面
  # GET /tasks/{id}/edit
  def edit
  end

  # タスク登録・更新完了画面
  # GET /tasks/{id}
  def show
  end

  # タスク登録処理
  # POST /tasks
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'タスクの登録に成功しました！' }
      else
        format.html { render :new }
      end
    end
  end

  # タスク更新処理
  # PATCH/PUT /tasks/1
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'タスクの更新に成功しました！' }
      else
        format.html { render :edit }
      end
    end
  end

  # タスク削除処理
  # DELETE /tasks/1
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'タスクの削除に成功しました！' }
    end
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:subject, :status, :priority, :deadline)
  end

  def sanitize_task_params
    params[:task][:priority] = params[:task][:priority].to_i
  end

  def search_form_params
    params.permit(:keyword, statuses:[])
  end

  def update_task_status_params
    params.require(:update_task_status).permit(:search_queries, :status => {})
  end
end