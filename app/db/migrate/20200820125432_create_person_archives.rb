class CreatePersonArchives < ActiveRecord::Migration[6.0]
  def change
    %i[email home_phone_number mobile_phone_number address].each do |attr|
      table_name = :"person_#{attr}_archives"
      create_table table_name do |t|
        t.references :person, foreign_key: { to_table: :people, on_delete: :cascade }
        t.string attr
      end

      add_index table_name, [:person_id, attr], unique: true, name: "index_person_archive_person_and_#{attr}"
    end
  end
end
