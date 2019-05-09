class Weightdate < ActiveRecord::Migration[5.2]
  def change
    add_column :weights, :weight_date, :datetime
  end
end
