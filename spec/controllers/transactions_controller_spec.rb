require "rails_helper"

describe TransactionsController, type: :controller do
  render_views

  describe "index" do
    let(:params) do
      {
        state: "California",
        year: 2015
      }
    end

    let(:page)                        { response.parsed_body }
    let(:transaction_collection)      do
      Transaction.where(state: params[:state]).where('extract(year from order_date) = ?', params[:year])
    end
    let(:expected_revenue)            { transaction_collection.sum(&:sales).round }
    let(:expected_revenue_per_order)  { expected_revenue / transaction_collection.count("DISTINCT order_id").round }
    let(:expected_distinct_customers) { transaction_collection.count("DISTINCT customer_id") }

    before do
      create_list(:transaction, 100)
      create(:transaction, state: 'California', order_date: Faker::Date.between(from: '2015-01-01', to: '2015-12-31'))

      get :index, params: params
    end

    it "renders basic layout elements" do
      expect(page).to include("Memory - Superstore")
      expect(page).to include("State")
      expect(page).to include("Year")
    end

    it 'renders the requested data' do
      expect(page).to include(formatted(expected_revenue))
      expect(page).to include(formatted(expected_revenue_per_order))
      expect(page).to include(expected_distinct_customers.to_s)
    end

    def formatted(figure)
      figure.to_s.reverse.scan(/.{1,3}/).join(',').reverse
    end
  end
end
