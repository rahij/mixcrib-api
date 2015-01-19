class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :title, null: false
      t.string :service, null: false
      t.string :identifier, null: false
      t.timestamps null: false
    end
  end
end
