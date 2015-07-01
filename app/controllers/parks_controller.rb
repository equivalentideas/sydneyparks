class ParksController < ApplicationController
  def show
    @park = Park.find(params[:id])
  end

  def random
    redirect_to Park.find(Random.new.rand(Park.first.id..Park.last.id))
  end
end
