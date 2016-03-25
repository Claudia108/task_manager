require_relative '../test_helper'

class UserCreatesNewTask < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_user_can_edit_a_task
    visit '/'
    click_link("New Task")

    assert_equal "/tasks/new", current_path

    fill_in "task[title]", with: "Learn Capybara"
    fill_in "task[description]", with: "practise different kinds of feature tests"
    click_button("Create Task")

    visit '/tasks'
    click_link("edit")

    id_edit = task_manager.all.last.id

    assert_equal "/tasks/#{id_edit}/edit", current_path

    fill_in "task[title]", with: "Learn fast"
    fill_in "task[description]", with: "figure out things yourself"
    click_button("update")

    save_and_open_page
    assert_equal "/tasks/#{id_edit}", current_path

    within("h1") do
      assert page.has_content?("Learn fast")
    end
  end
end
