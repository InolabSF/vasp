class CreateSquares < ActiveRecord::Migration
  def change
    create_table :squares do |t|
      t.float :ambient
      t.float :co
      t.float :co2
      t.float :humidity
      t.float :no2
      t.float :ozone_s
      t.float :so2
      t.float :temp_c
      t.float :uv
      t.float :lat
      t.float :lng
      t.float :radius
      t.float :pressure

      t.timestamps null: false
    end
  end
end
