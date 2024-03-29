class CreateNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :notes do |t|
      t.string :title
      t.string :description
      t.text :body
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
