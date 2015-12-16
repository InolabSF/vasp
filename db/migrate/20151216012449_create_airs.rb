class CreateAirs < ActiveRecord::Migration
  def change
    create_table :airs do |t|
      t.float :SO2
      t.float :Ozone_S
      t.float :south
      t.float :north
      t.float :west
      t.float :east

      t.timestamps null: false
    end
  end
end
