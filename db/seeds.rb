# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([
  {name: 'Divyaa Manimaran Elango', email: 'divyaamanimaran.elango@ncirl.ie', role: 'advisor', password: SecureRandom.urlsafe_base64(4)},
  {name: 'Alan John', email: 'aj@student.ncirl.ie', role: 'student', password: SecureRandom.urlsafe_base64(4)},
  {name: 'Mark', email: 'mark@student.ncirl.ie', role: 'student', password: SecureRandom.urlsafe_base64(4)},
  {name: 'Marie', email: 'marie@student.ncirl.ie', role: 'student', password: SecureRandom.urlsafe_base64(4)},
  {name: 'Emily', email: 'emily@student.ncirl.ie', role: 'student', password: SecureRandom.urlsafe_base64(4)},
])
