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

  test 'capture' do
    visit '/'

    click_button 'Run'
    assert page.has_selector?(:link_or_button, 'Stop', visible: true)
    assert page.has_selector?(:link_or_button, 'Run', visible: false)

    click_button 'Stop'
    assert page.has_selector?(:link_or_button, 'Run', visible: true)
    assert page.has_selector?(:link_or_button, 'Stop', visible: false)
  end

  test 'empty state commodities' do
    assert_nil $redis.zscore('commodities', 'GOOG')

    visit '/'
    page.must_have_content('Commodities empty, please run to capture')
    assert_nil page.find_by_id('commodity-GOOG')
  end

  test 'commodities list' do
    $redis.zadd('commodities', 10.0, 'GOOG')

    visit '/'
    page.must_have_content('GOOG')
    assert_not_nil page.find_by_id('commodity-GOOG')
  end

end