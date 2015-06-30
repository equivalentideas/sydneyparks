class CreateParks < ActiveRecord::Migration
  def change
    create_table :parks do |t|
      t.string :name
      t.string :latitude
      t.string :longitude
      t.string :osm_id

      t.timestamps
    end
  end
end
