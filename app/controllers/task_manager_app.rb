
class TaskManagerApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)

  get '/' do
    erb :dashboard
  end

  get '/tasks' do
    @tasks = task_manager.all
    erb :index
  end

  get '/tasks/new' do
    erb :new
  end

  post '/tasks' do
    task_manager.create(params[:task])
    redirect '/tasks'
  end

  get '/tasks/:id' do |id|
    @task = task_manager.find(id.to_i)
    erb :show
  end

  get '/tasks/:id/edit' do |id|
    @task = task_manager.find(id.to_i)
    erb :edit
  end

  put '/tasks/:id' do |id|
    task_manager.update(id.to_i, params[:task])
    redirect "/tasks/#{id}"
  end

  delete '/tasks/:id' do |id|
    task_manager.destroy(id.to_i)
    redirect '/tasks'
  end

  not_found do
    erb :error
  end

  def task_manager
    if ENV["RACK_ENV"] == "test"
      database = Sequel.sqlite('db/task_manager_test.sqlite')
    else
      database = Sequel.sqlite('db/task_manager_development.sqlite')
    end
    @task_manager ||= TaskManager.new(database)
  end
end
