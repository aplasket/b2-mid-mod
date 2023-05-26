require "rails_helper"

RSpec.describe "/departments, index page" do
  describe "as a user" do
    it "shows dept attributes" do
      dept1 = Department.create!(name: "Sales", floor: "basement")
      dept2 = Department.create!(name: "Development", floor: "top")

      visit "/departments"

      expect(page).to have_content("All Departments")
      expect(page).to have_content(dept1.name)
      expect(page).to have_content("Floor: #{dept1.floor}")
      expect(page).to have_content(dept2.name)
      expect(page).to have_content("Floor: #{dept2.floor}")

      # save_and_open_page
    end

    it "shows each depts employees" do
      dept1 = Department.create!(name: "Sales", floor: "basement")
      emply1 = dept1.employees.create!(name: "Suzie Goodfield", level: 2)

      dept2 = Department.create!(name: "Development", floor: "top")
      emply2 = dept2.employees.create!(name: "Bob Minder", level: 1)
      emply3 = dept2.employees.create!(name: "Todd E", level: 9)

      visit "/departments"
      # save_and_open_page

      within "#dept-#{dept1.id}" do
        expect(page).to have_content("Employees")
        expect(page).to have_content(emply1.name)
        expect(page).to_not have_content(emply2.name)
        expect(page).to_not have_content(emply3.name)
      end
    end
  end
end