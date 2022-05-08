class CreateUserProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :user_profiles do |t|
      t.text :bio
      t.string :name
      t.datetime :born_at
      t.string :gender
      t.integer :height
      t.integer :weight
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
