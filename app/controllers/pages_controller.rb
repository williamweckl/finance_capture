class PagesController < ApplicationController
  def home
    companies = ["YHOO","AAPL","GOOG","MSFT","BZK16.NYM"]
    @commodities = []
    companies.each do |company|
      price_sales = $redis.zscore('commodities', company)
      if price_sales
        @commodities << {name: company, price_sales: price_sales}
      end
    end
  end
end
