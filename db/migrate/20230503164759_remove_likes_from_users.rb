class RemoveLikesFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_reference :likes, :users, null: false, foreign_key: true
    add_reference :likes, :user, null: false, foreign_key: true
  end
end
