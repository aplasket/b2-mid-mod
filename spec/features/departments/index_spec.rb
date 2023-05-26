require "rails_helper"

RSpec.describe "/departments, index page" do
  describe "as a user" do
    it "shows dept attributes" do
      dept1 = Department.create!(name: "Sales", floor: "basement")
      dept2 = Department.create!(name: "Development", floor: "top")

      visit "/departments"
      save_and_open_page
      expect(page).to have_content("All Departments")
      expect(page).to have_content(dept1.name)
      expect(page).to have_content("Floor: #{dept1.floor}")
      expect(page).to have_content(dept2.name)
      expect(page).to have_content("Floor: #{dept2.floor}")
    end

    it "shows each depts employees" do

    end
  end
end