class CreateInterests < ActiveRecord::Migration[7.0]
  def change
    create_table :interests do |t|
      t.string :target
      t.jsonb :data
      t.string :operator

      t.timestamps
    end
  end
end
