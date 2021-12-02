Task.destroy_all
Project.destroy_all
Assignment.destroy_all
User.destroy_all

puts "DB clean"

user_seed = User.new(
  first_name: "Lorran",
  last_name: "Monteiro",
  email: "lorranmcm@gmail.com",
  password: "123456"
)
user_seed.save!
puts "User Created"

counter = 0

5.times do
  counter += 1

  project_seed = Project.new(
    title: "Project #{counter}",
  )
  project_seed.user = user_seed
  project_seed.save!

  puts "Created Project"

  task_seed = Task.new(
    title: "Task #{counter}",
    description: "Lorem Ipsum",
  )
  task_seed.project = project_seed
  task_seed.save!

  puts "Created Task"
end
