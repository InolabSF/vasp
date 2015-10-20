class CreateSensors < ActiveRecord::Migration
  def change
    create_table :sensors do |t|
      t.integer :type
      t.float :lat
      t.float :lng
      t.float :weight
      t.datetime :timestamp

      t.timestamps null: false
    end
  end
end
