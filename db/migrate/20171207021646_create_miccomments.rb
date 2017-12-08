class CreateMiccomments < ActiveRecord::Migration
  def change
    create_table :miccomments do |t|
      t.integer :micropost_id
      t.integer :commenter_id
      t.integer :comment_to
      t.text :content

      t.timestamps null: false
    end

    add_index :miccomments, :micropst_id
    add_index :miccomments, :commenter_id
    add_index :miccomments, :comment_to
  end
end
