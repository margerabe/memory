class TransactionsController < ApplicationController
  def index
    @state_select = Transaction.distinct.pluck(:state).sort
    @year_select = ActiveRecord::Base.connection.execute(sql_years).values.flatten.compact.sort
    @transactions = Transaction.where(state: params[:state]).where('extract(year from order_date) = ?', params[:year])

    @revenue = revenue
    @distinct_orders = @transactions.count("DISTINCT order_id").round
    @distinct_customers = @transactions.count("DISTINCT customer_id")
  end

  private

  def sql_years
    "SELECT DISTINCT EXTRACT(YEAR FROM order_date)::Integer from TRANSACTIONS"
  end

  def revenue
    @transactions.sum(&:sales).round
  end
end
