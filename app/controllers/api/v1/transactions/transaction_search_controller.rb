class Api::V1::Transactions::TransactionSearchController < ApplicationController

  def index
    render json: Transaction.where(transaction_search_params)
  end
  def show
    render json: Transaction.find_by(transaction_search_params)
  end

  private

    def transaction_search_params
      params.permit(:id, :result, :credit_card_number, :credit_card_expiration_date, :created_at, :updated_at)
    end

end
