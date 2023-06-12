class CreatePlays < ActiveRecord::Migration[6.1]
  def change
    create_table :plays do |t|
      t.string :name
      t.string :email
      t.text :positions
      t.boolean :is_winner
      t.string :level

      t.timestamps
    end
  end
end
