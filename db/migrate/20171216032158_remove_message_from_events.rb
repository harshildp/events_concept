class RemoveMessageFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :message, :text
  end
end
