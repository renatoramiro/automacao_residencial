class AddStatusToServices < ActiveRecord::Migration
  def change
    add_column :services, :status, :boolean, default: false
  end
end
