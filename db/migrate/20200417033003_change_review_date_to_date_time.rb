class ChangeReviewDateToDateTime < ActiveRecord::Migration[6.0]
  def change
    change_column :reviews, :date, :date
  end
end
