class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.string :name
      t.decimal :lat
      t.decimal :lng

      t.timestamps null: false
    end
  end
end
