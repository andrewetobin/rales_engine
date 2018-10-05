class Api::V1::Items::ItemRandomController < ApplicationController


  def show
    render json: Item.order('RANDOM()').limit(1)
  end

end
