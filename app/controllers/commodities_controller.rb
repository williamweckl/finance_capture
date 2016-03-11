class CommoditiesController < ApplicationController
  include ActionController::Live

  def capture
    response.headers['Content-Type'] = 'text/event-stream'
    time_in_minutes = params[:time_in_minutes] || 10
    sse = SSE.new(response.stream)
    begin
      loop do
        commodities = Yahoo::FinanceAPI.new.get_commodities.to_json
        sse.write(commodities)
        sleep (time_in_minutes.to_i * 60)
      end
    rescue IOError
      # Client Disconnected
    ensure
      sse.close
    end

    render nothing: true
  end
end
