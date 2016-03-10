class CommoditiesController < ApplicationController
  include ActionController::Live

  def capture
    response.headers['Content-Type'] = 'text/event-stream'
    sse = SSE.new(response.stream)
    begin
      loop do
        $redis.zadd("commodities", 10.0, 'GOOG')
        sse.write({name: 'GOOG', price_sales: 10.0}.to_json)
        sleep 1
      end
    rescue IOError
      # Client Disconnected
    ensure
      sse.close
    end

    render nothing: true
  end
end
