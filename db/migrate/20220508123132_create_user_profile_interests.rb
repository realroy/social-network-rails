class CreateUserProfileInterests < ActiveRecord::Migration[7.0]
  def change
    create_table :user_profile_interests do |t|
      t.references :interest, null: false, foreign_key: true
      t.references :user_profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
