Task.destroy_all
Project.destroy_all
Assignment.destroy_all
User.destroy_all

puts "DB clean"

user_seed = User.new(
  first_name: "Zippora",
  last_name: "Latzko",
  email: "zippy@gmail.com",
  password: "123456"
)
user_seed.save!
puts "User Created"

project_seed_one = Project.new(title: "Demo day")
project_seed_one.user = user_seed
project_seed_one.save!

project_seed_two = Project.new(title: "Happy hour")
project_seed_two.user = user_seed
project_seed_two.save!

puts "Created Projects"

task_seed_one = Task.new(
  title: "Get documents on Le Wagon",
  description: "Milene is waiting for us to catch some documents to deliver in the Correios",
  address: "R. Alm. Gonçalves, 5 - Copacabana, Rio de Janeiro"
)
task_seed_one.project = project_seed_one
task_seed_one.save!

task_seed_two = Task.new(
  title: "Send the documents",
  description: "We need to send this documents to Le Wagon SP, the address is written on the note Milene gave you.",
  address: "Avenida Nossa Senhora de Copacabana, 540"
)
task_seed_two.project = project_seed_one
task_seed_two.save!

task_seed_three = Task.new(
  title: "Pick up Pilar and go to Mark`s kissing arena",
  description: "After the delivery of the documents on Correios, give Pilar a ride to Mark`s kissing arena.",
  address: "Av. Nossa Sra. de Copacabana, 1236"
)
task_seed_three.project = project_seed_one
task_seed_three.save!

puts "Created Task"
