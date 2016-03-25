require_relative '../test_helper'

class UserCreatesNewTask < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_user_can_delete_a_task
    task_manager.create(title: "Learn Capybara", description: "so much fun")

    visit '/tasks'

    within("#list") do
      assert page.has_content?("Learn Capybara")
    end

    click_button("delete")
    assert_equal "/tasks", current_path

    refute page.has_content?("Learn Capybara")
  end
end
