class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string :title
      t.datetime :date
      t.text :content
      t.integer :user_id

      t.timestamps
    end
  end
end
