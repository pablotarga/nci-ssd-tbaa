# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([
  {name: 'Advisor John', email: 'advisor1@ncirl.ie', role: 'advisor', password: '123'},
  {name: 'Advisor Ellen', email: 'advisor2@ncirl.ie', role: 'advisor', password: '123'},
  {name: 'Alan', email: 'aj@student.ncirl.ie', role: 'student', password: '123'},
  {name: 'Cathal', email: 'cathal@student.ncirl.ie', role: 'student', password: '123'},
  {name: 'Marie', email: 'marie@student.ncirl.ie', role: 'student', password: '123'},
  {name: 'Emily', email: 'emily@student.ncirl.ie', role: 'student', password: '123'},
])
