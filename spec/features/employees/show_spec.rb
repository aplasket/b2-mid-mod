require "rails_helper"

RSpec.describe "/employees/:id, employee show page" do
  describe "as a user" do
    it "see employee's name and dept" do
      dept1 = Department.create!(name: "Sales", floor: "basement")
      emply1 = dept1.employees.create!(name: "Suzie Goodfield", level: 2)

      dept2 = Department.create!(name: "Development", floor: "top")
      emply2 = dept2.employees.create!(name: "Bob Minder", level: 1)
      emply3 = dept2.employees.create!(name: "Todd E", level: 9)

      visit "/employees/#{emply1.id}"

      expect(page).to have_content("Employee Name: #{emply1.name}")
      expect(page).to have_content("Department: #{dept1.name}")
      expect(page).to_not have_content("Employee Name: #{emply2.name}")
      expect(page).to_not have_content("Department: #{dept2.name}")

      visit "/employees/#{emply2.id}"

      expect(page).to have_content("Employee Name: #{emply2.name}")
      expect(page).to have_content("Department: #{dept2.name}")
      expect(page).to_not have_content("Employee Name: #{emply1.name}")
      expect(page).to_not have_content("Department: #{dept1.name}")
    end

    it "sees list of all tickets from oldest to newest" do
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
      
      
      visit "/employees/#{emply1.id}"

      expect(page).to have_content("Tickets")
      expect(page).to have_content("Employee Name: #{emply1.name}")
      expect(page).to have_content("Department: #{dept1.name}")
      expect(ticket2.subject).to appear_before(ticket1.subject)

      save_and_open_page

      visit "/employees/#{emply2.id}"

      expect(page).to have_content("Tickets")
      expect(page).to have_content("Employee Name: #{emply2.name}")
      expect(page).to have_content("Department: #{dept2.name}")
      expect(ticket3.subject).to appear_before(ticket1.subject)
    end

    it "see oldest ticket assigned to employee listed separately" do
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
      
      
      visit "/employees/#{emply1.id}"
      
      within "#old-tick-#{emply1.id}" do
        expect(page).to have_content("Oldest Ticket: #{ticket2.subject}")
        expect(page).to_not have_content("Oldest Ticket: #{ticket1.subject}")
      end

      visit "/employees/#{emply2.id}"
      save_and_open_page
      within "#old-tick-#{emply2.id}" do
        expect(page).to have_content("Oldest Ticket: #{ticket3.subject}")
        expect(page).to_not have_content("Oldest Ticket: #{ticket1.subject}")
      end

    end
  end
end