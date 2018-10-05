class Api::V1::Customers::CustomerSearchController < ApplicationController

  def index
    render json: Customer.where(customer_search_params)
  end
  def show
    render json: Customer.find_by(customer_search_params)
  end

  private

    def customer_search_params
      params.permit(:first_name, :last_name, :created_at, :updated_at)
    end

end
