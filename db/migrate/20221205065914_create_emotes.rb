class CreateEmotes < ActiveRecord::Migration[7.0]
  def change
    create_table :emotes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :micropost, null: false, foreign_key: true
      t.string :emoji
      t.timestamps
    end
  end
end
