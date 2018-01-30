class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.datetime :date
      t.references :student1
      t.references :student2

      t.timestamps
    end
  end
end
