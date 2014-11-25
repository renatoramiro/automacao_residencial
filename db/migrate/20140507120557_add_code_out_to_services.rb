class AddCodeOutToServices < ActiveRecord::Migration
  def change
    add_column :services, :code_out, :integer
  end
end
