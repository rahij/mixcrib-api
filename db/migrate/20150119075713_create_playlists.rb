class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.integer :user_id, null: false
      t.string :name,  null: false
      t.boolean :private, default: true, null: false
      t.timestamps null: false
    end
  end
end
