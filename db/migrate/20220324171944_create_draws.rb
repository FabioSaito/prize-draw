class CreateDraws < ActiveRecord::Migration[7.0]
  def change
    create_table :draws do |t|
      t.string :winner

      t.timestamps
    end
  end
end
