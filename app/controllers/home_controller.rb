class HomeController < ApplicationController
  def index
  end

  def calculate
    @result = CalculationService.call(params[:expression])
    render status: :see_other
  end
end
