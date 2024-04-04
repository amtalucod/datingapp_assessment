class AddSwipeToMessage < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :swipe_id, :bigint
  end
end
