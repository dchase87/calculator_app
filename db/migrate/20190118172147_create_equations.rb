class CreateEquations < ActiveRecord::Migration[5.1]
  def change
    create_table :equations do |t|
      t.string :formula

      t.timestamps
    end
  end
end
