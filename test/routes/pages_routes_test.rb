class PagesRoutesTest < ActionController::TestCase
  test "should route to home" do
    assert_routing '/home', { controller: "pages", action: "home" }
  end
end