class TransactionsController < ApplicationController
  def index
    @state_select = Transaction.distinct.pluck(:state).sort
    @year_select = ActiveRecord::Base.connection.execute(sql_years).values.flatten.compact!.sort
    
    @transactions = Transaction.where(state: params[:state]).where('extract(year from order_date) = ?', params[:year])
    
    @revenue = revenue
    @revenue_per_order = revenue_per_order
    @customers = customers
  end
  
  private
  
  def sql_years
    "SELECT DISTINCT EXTRACT(YEAR FROM order_date)::Integer from TRANSACTIONS"
  end

  def revenue
    @revenue_amount = @transactions.sum(&:sales).round
    @revenue_amount != 0 ? "EUR #{@revenue_amount}" : "-"
  end

  def revenue_per_order
    @revenue_amount != 0 ? "EUR #{(@revenue_amount / @transactions.count("DISTINCT order_id")).round}" : "-"
  end

  def customers
    @revenue_amount != 0 ? @transactions.count("DISTINCT customer_id") : "-"
  end
end
