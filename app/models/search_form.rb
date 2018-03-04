class SearchForm
  include ActiveModel::Model

  attr_accessor :keyword, :statuses

  def search
    conditions = []
    values = []

    # キーワード（部分一致）
    if !@keyword.empty?
      conditions.push("subject LIKE(?)")
      values.push("%#{@keyword}%")
    end

    # ステータス（複数選択可）
    if @statuses
      place_holders = Array.new(@statuses.size, "?").join(",")
      conditions.push("status in (#{place_holders})")
      to_i_statuses = @statuses.map { |s| s.to_i }
      values.push(*to_i_statuses)
    end

    # 条件を動的に組み立てる
    Task.where(conditions.join(" AND "), *values)
  end
end