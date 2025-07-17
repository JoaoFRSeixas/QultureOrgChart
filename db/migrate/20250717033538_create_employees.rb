class CreateEmployees < ActiveRecord::Migration[8.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :email
      t.string :picture
      t.references :company, null: false, foreign_key: true
      t.integer :manager_id, index: true

      t.timestamps
    end
  end
end
