class CommoditiesController < ApplicationController
  include ActionController::Live

  def capture
    response.headers['Content-Type'] = 'text/event-stream'
    sse = SSE.new(response.stream)
    begin
      loop do
        sse.write('a')
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
