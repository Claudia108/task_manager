require_relative '../test_helper'

class UserCreatesNewTask < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_user_can_create_a_new_task
    visit '/'
    click_link("New Task")

    assert_equal "/tasks/new", current_path

    fill_in "task[title]", with: "Learn Capybara"
    fill_in "task[description]", with: "practise different kinds of feature tests"
    click_button("Create Task")

    assert_equal "/tasks", current_path

    within("#list") do
      assert page.has_content?("Learn Capybara")
    end
  end
end
