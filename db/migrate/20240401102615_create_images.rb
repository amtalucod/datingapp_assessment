class CreateImages < ActiveRecord::Migration[7.1]
  def change
    create_table :images do |t|
      t.references :user, null: false, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end
