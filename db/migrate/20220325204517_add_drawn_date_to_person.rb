class AddDrawnDateToPerson < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :drawn_date, :datetime
  end
end
