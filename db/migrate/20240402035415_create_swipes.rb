class CreateSwipes < ActiveRecord::Migration[7.1]
  def change
    create_table :swipes do |t|
      t.boolean :liked

      t.timestamps
    end
  end
end
