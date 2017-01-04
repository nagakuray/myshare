class CreateOwnerships < ActiveRecord::Migration
  def change
    create_table :ownerships do |t|
      t.references :user, index: true, foreign_key: true
      t.string :slide_id
      t.string :type

      t.timestamps null: false
      t.index [:user_id, :slide_id,:type], unique: true
    end
  end
end
