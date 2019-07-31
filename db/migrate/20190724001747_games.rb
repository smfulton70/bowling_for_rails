class Games < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :name
      t.integer :final_score, default: nil

      t.timestamps
    end
  end
end
