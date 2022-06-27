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
    let(:page)      { response.parsed_body }
    let(:revenue)   { Transaction.where(state: params[:state]).where('extract(year from order_date) = ?', params[:year]).sum(&:sales).round }
    
    before do
      create_list(:transaction, 100)
      create(:transaction, state: 'California', order_date: Faker::Date.between(from: '2015-01-01', to: '2015-12-31'))

      get :index, params: params
    end

    it "renders the template with basic elements" do
      expect(page).to include("Memory - Superstore")
      expect(page).to include("State")
      expect(page).to include("Year")
    end

    it 'renders correct revenue' do
      formatted_revenue = revenue.to_s.reverse.scan(/.{1,3}/).join(',').reverse
      expect(page).to include(formatted_revenue)
    end
  end
end