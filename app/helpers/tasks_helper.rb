module TasksHelper
  # 日付のフォーマットを行う
  def format_datetime(datetime)
    datetime.strftime('%Y-%m-%d %H:%M')
  end

  # Taskのenum「status」に対して
  # gem「enum_help」のメソッドで返ってくる{"英語キー" => "日本語キー"}を
  # {"日本語キー" => 値（数字）}に変換する。
  def generate_task_statuses_i18n
    Task.statuses_i18n.invert.map { |k,v| [k, Task.statuses[v]]}.to_h
  end

  # Taskのenum「priority」に対して
  # gem「enum_help」のメソッドで返ってくる{"英語キー" => "日本語キー"}を
  # {"日本語キー" => 値（数字）}に変換する。
  def generate_task_priorities_i18n
    Task.priorities_i18n.invert.map { |k,v| [k, Task.priorities[v]]}.to_h
  end
end