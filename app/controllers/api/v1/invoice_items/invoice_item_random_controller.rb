class Api::V1::InvoiceItems::InvoiceItemRandomController < ApplicationController


  def show
    render json: InvoiceItem.order('RANDOM()').limit(1)
  end

end
