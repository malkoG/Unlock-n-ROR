class CreateScores < ActiveRecord::Migration[5.0]
  def change
    create_table :scores do |t|
      t.references :user, foreign_key: true
      t.references :scorable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
