class CreateBuildingArchives < ActiveRecord::Migration[6.0]
  def change
    create_table :building_archives do |t|
      t.belongs_to :people, null: false, foreign_key: true
      t.string :manager_name

      t.timestamps
    end
  end
end
