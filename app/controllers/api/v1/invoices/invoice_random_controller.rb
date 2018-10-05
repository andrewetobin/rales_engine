class Api::V1::Invoices::InvoiceRandomController < ApplicationController

  def show
    render json: Invoice.order('RANDOM()').limit(1)
  end

end
