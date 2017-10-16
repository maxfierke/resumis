load File.join(Rails.root, 'lib', 'tasks', 'resumis_script.thor')

namespace :resumis do |t|
  desc "Task for adding a new, active user to Resumis"
  task useradd: :environment do
    thor_task = ResumisScript.new
    thor_task.invoke(:useradd)
  end
end
