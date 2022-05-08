class AddSuggestToInterests < ActiveRecord::Migration[7.0]
  def change
    add_column :interests, :suggest, :boolean
  end
end
