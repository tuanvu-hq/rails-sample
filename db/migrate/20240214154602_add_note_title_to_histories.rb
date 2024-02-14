class AddNoteTitleToHistories < ActiveRecord::Migration[7.1]
  def change
    add_column :histories, :note_title, :string
  end
end
