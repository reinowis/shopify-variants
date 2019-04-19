class CreateVariants < ActiveRecord::Migration[5.2]
  def change
    create_table :variants do |t|
      t.string :name
      t.belongs_to :shop, foreign_key: true

      t.timestamps
    end
  end
end
