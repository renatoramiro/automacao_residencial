class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :title
      t.string :code
      t.text :description

      t.timestamps
    end
  end
end
