class Api::V1::Merchants::MerchantItemsCountController < ApplicationController
  def index
    params[:quantity] = 5 unless params[:quantity]
    render json: Merchant.most_items(params[:quantity].to_i)
  end

end
