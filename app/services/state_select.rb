class StateSelect
  def initialize; end

  def call
    Transaction.distinct.pluck(:state).sort.prepend("ALL")
  end
end
