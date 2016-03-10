require 'test_helper'
class CaptureFlowsTest < ActionDispatch::IntegrationTest

  setup do
    Capybara.current_driver = Capybara.javascript_driver # :selenium by default
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

end