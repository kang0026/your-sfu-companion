class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :c_name
      t.integer :c_number
      t.string :c_section
    end
  end
end
