require_relative '../test_helper'

class TaskManagerTest < Minitest::Test
  include TestHelpers

  def test_create_creates_a_task
    task_manager.create({
      :title       => "a title",
      :description => "a description"
    })

    task = task_manager.all.last
    assert_equal "a title", task.title
    assert_equal "a description", task.description
  end

  def test_all_shows_all_tasks
    create_tasks(3)

    all = task_manager.all

    assert_equal 3, all.length
    assert_equal Task, all[0].class
    assert_equal "Task Title 1", all[0].title
    assert_equal "Task Title 2", all[1].title
    assert_equal "Task Title 3", all[2].title
  end

  def test_find_shows_task_by_id
    create_tasks(5)
    task = task_manager.all.last

    assert_equal "Task Title 5", task.title
    assert_equal "Task Description 5", task.description
  end

  def test_update_saves_new_information_to_current_task
    create_tasks(3)

    task = task_manager.all[1]
    assert_equal "Task Title 2", task.title
    assert_equal "Task Description 2", task.description

    updated_task_details = {
      :title       => "Updated Title",
      :description => "Updated Description"
    }

    task_manager.update(task.id, updated_task_details)
    task = task_manager.all[1]

    assert_equal "Updated Title", task.title
    assert_equal "Updated Description", task.description
  end

  def test_destroy_removes_task
    create_tasks
    all_tasks = task_manager.all

    assert_equal 2, all_tasks.size
    assert all_tasks.any? { |task| task.title == "Task Title 2"}

    id_delete = task_manager.all.last.id

    task_manager.destroy(id_delete)
    all_tasks = task_manager.all

    assert_equal 1, all_tasks.size
    refute all_tasks.any? { |task| task.title == "Task Title 2"}
  end
end
