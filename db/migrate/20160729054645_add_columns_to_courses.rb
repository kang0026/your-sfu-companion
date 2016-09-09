class AddColumnsToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :c_time, :string
    add_column :courses, :c_location, :string
    add_column :courses, :c_examTime, :string
    add_column :courses, :c_examLocation, :string
    
  end
end
