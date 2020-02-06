class AddFullNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :full_name, :string, length: {maximum: 50}
  end
end
