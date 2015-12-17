class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :air
      t.float :lat
      t.float :lng
      t.string :uuid
      t.string :name
      t.datetime :timestamp

      t.timestamps null: false
    end
  end
end
