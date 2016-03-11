require 'test_helper'
class CaptureFlowsTest < ActionDispatch::IntegrationTest

  setup do
    Capybara.current_driver = Capybara.javascript_driver # :selenium by default
  end

  teardown do
    $redis.flushall
  end

  test 'home' do
    visit '/'
    page.must_have_content('Financial Capture')
  end

  test 'empty state commodities' do
    assert_nil $redis.get('GOOG')

    visit '/'
    page.must_have_content('Commodities empty, please run to capture')
    assert_raises Capybara::ElementNotFound do
      page.find_by_id('commodity-GOOG')
    end
  end

  test 'commodities list' do
    $redis.set('GOOG', {"symbol":"GOOG","name":"Alphabet Inc.","change":7.58,"last_trade_price":712.82}.to_json)

    visit '/'
    page.must_have_content('GOOG')
    assert_not_nil page.find_by_id('commodity-GOOG')
  end

end