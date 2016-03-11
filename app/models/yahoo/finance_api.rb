module Yahoo
  class FinanceAPI

    def initialize(*args)
      @api_url = 'https://query.yahooapis.com/v1/public/yql'
      @query = 'select * from yahoo.finance.quotes where symbol in ("YHOO","AAPL","GOOG","MSFT","CCH16.NYB")'
      @env = 'store://datatables.org/alltableswithkeys'
    end

    def get_commodities
      query = {q: @query,
               format: 'json',
               diagnostics: false,
               env: @env
      }
      response = HTTParty.get(@api_url, query: query)

      if response.code = 200
        commodities = []
        json = JSON.parse(response.body)

        json['query']['results']['quote'].each do |quote|
          begin
            if quote['Name']
              commodity = {symbol: quote['symbol'],
                           name: quote['Name'],
                           change: quote['Change'].sub('%','').to_f,
                           last_trade_price: quote['LastTradePriceOnly'].to_f,
              }
              $redis.set(quote['symbol'], commodity.to_json)
              commodities << commodity
            else
              {error: 'Yahoo API data returned is not well formated.'}
            end
          rescue
            {error: 'Yahoo API data returned is not well formated.'}
          end
        end

        commodities
      else
        {error: 'an error occurred while using Yahoo API.'}
      end
    end

  end
end