# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
dept1 = Department.create!(name: "Sales", floor: "basement")
emply1 = dept1.employees.create!(name: "Suzie Goodfield", level: 2)

dept2 = Department.create!(name: "Development", floor: "top")
emply2 = dept2.employees.create!(name: "Bob Minder", level: 1)
emply3 = dept2.employees.create!(name: "Todd E", level: 9)

ticket1 = Ticket.create!(subject: "printers broken", age: 5)
ticket2 = Ticket.create!(subject: "sos - product broken", age: 13)
ticket3 = Ticket.create!(subject: "just complicated user error", age: 20)

etx1 = EmployeeTicket.create!(employee_id: emply1.id, ticket_id: ticket1.id)
etx2 = EmployeeTicket.create!(employee_id: emply1.id, ticket_id: ticket2.id)

etx3 = EmployeeTicket.create!(employee_id: emply2.id, ticket_id: ticket1.id)
etx4 = EmployeeTicket.create!(employee_id: emply2.id, ticket_id: ticket3.id)
