class TransactionsController < ApplicationController
  def index
    @state_select = StateSelect.new.call
    @year_select = YearSelect.new.call
    @transactions = BuildTransactions.new(state: params[:state], year: params[:year]).call

    @revenue = revenue
    @distinct_orders = CountDistinct.new(collection: @transactions, column: "order_id").call.round
    @average_order_per_revenue = @revenue / @distinct_orders if @distinct_orders != 0
    @distinct_customers = CountDistinct.new(collection: @transactions, column: "customer_id").call
  end

  private

  def revenue
    @transactions.sum(:sales).round
  end
end
