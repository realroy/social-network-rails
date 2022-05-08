class AddConsentToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :consent, :boolean
  end
end
