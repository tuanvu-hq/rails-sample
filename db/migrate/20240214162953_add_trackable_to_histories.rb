class AddTrackableToHistories < ActiveRecord::Migration[7.1]
  def change
    add_column :histories, :trackable_id, :integer
    add_column :histories, :trackable_type, :string
  end
end
