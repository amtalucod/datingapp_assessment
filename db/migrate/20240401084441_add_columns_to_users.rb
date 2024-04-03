class AddColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :mobile_number, :string
    add_column :users, :birthdate, :date
    add_column :users, :gender, :string
    add_column :users, :sexual_orientation, :string
    add_column :users, :gender_interest, :string
    add_column :users, :school, :string
    add_column :users, :bio, :text
  end
end
