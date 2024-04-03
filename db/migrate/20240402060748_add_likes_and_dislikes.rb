class AddLikesAndDislikes < ActiveRecord::Migration[7.1]
  def change
    add_reference :swipes, :liked_user, foreign_key: { to_table: :users }
    add_reference :swipes, :disliked_user, foreign_key: { to_table: :users }
  end
end
