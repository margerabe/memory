class BuildTransactions
  def initialize(state:, year:)
    @state = state
    @year = year
  end

  def call
    build_transactions
  end

  private

  def build_transactions
    @state == "ALL" ? transactions_full_year : transactions_full_year.where(state: @state)
  end

  def transactions_full_year
    transactions_full_year = Transaction.where('extract(year from order_date) = ?', @year)
  end
end
