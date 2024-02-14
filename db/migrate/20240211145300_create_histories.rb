class CreateHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :histories do |t|
      t.references :note, null: false, foreign_key: true
      t.string :action

      t.timestamps
    end
  end
end
