class AddColumnToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :set_time, :datetime
  end
end
