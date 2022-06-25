class TransactionsController < ApplicationController
  def index
    @state_select = Transaction.distinct.pluck(:state)
    sql = "SELECT DISTINCT EXTRACT(YEAR FROM order_date)::Integer from TRANSACTIONS"
    @year_select = ActiveRecord::Base.connection.execute(sql).values.flatten.compact! #check years for that state?
    
    @transactions = Transaction.where(state: params[:state]).where('extract(year from order_date) = ?', params[:year]) #per state per year


    @revenue = @transactions.sum(&:sales)
    @revenue_per_order = (@revenue/@transactions.count).round
    @customers_count = @transactions.count("DISTINCT customer_id")
  end
end
