class YearSelect
  def initialize; end

  def call
    ActiveRecord::Base.connection.execute(sql_years).values.flatten.compact.sort
  end

  private

  def sql_years
    "SELECT DISTINCT EXTRACT(YEAR FROM order_date)::Integer from TRANSACTIONS"
  end
end
