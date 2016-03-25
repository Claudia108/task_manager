require 'sequel'

database = Sequel.sqlite('db/task_manager_test.sqlite')

database.create_table :tasks do
  primary_key :id
  String      :title,       :size => 50
  String      :description, :size => 300
end
