class Frames < ActiveRecord::Migration[5.2]
  def change
    create_table :frames do |t|
      t.integer :ball_one, default: 0
      t.integer :ball_two, default: 0
      t.integer :ball_three, default: nil
      t.integer :frame_number, default: 0
      t.integer :frame_score, default: 0
      t.boolean :spare, default: false
      t.boolean :strike, default: false
      t.references :game, foreign_key: true

      t.timestamps
    end
  end
end
