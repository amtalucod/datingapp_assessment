class AddMatchedToSwipes < ActiveRecord::Migration[7.1]
  def change
    add_column :swipes, :matched, :boolean
  end
end
