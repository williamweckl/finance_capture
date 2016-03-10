class CommoditiesRoutesTest < ActionController::TestCase
  test "should route to capture" do
    assert_routing '/commodities/capture', { controller: "commodities", action: "capture" }
  end
end