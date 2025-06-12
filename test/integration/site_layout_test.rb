require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    get root_path
    assert_template "static_pages/home"
    assert_select "[href=?]", root_path, count: 2
    assert_select "[href=?]", help_path
    assert_select "[href=?]", about_path
    assert_select "[href=?]", contact_path
    assert_select "[href=?]", signup_path

    get contact_path
    assert_select "title", full_title("Contact")

    get signup_path
    assert_select "title", full_title("Sign up")

    get help_path
    assert_select "title", full_title("Help")

    get about_path
    assert_select "title", full_title("About")

    get root_path
    assert_select "title", full_title("Home")
  end
end
