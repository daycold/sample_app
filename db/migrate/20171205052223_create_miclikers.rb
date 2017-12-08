class CreateMiclikers < ActiveRecord::Migration
  def change
    create_table :miclikers do |t|
      t.integer :liker_id
      t.integer :micropost_id

      t.timestamps null: false
    end

    add_index :miclikers, :liker_id
    add_index :miclikers, :micropost_id
    add_index :miclikers, [:liker_id,:micropost_id]
  end
end
