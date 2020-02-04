# lib/tasks/my_task.rake

namespace :custom do
  desc "This take does something useful!"

  task :do_it do
    puts "Do something useful!"
  end
end
