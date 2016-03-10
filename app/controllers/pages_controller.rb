class PagesController < ApplicationController
  def home
    @commodities = [{name: 'foo', price_sales: 'bar'}]
  end
end
