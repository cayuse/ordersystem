class CreateSitemizations < ActiveRecord::Migration
  def self.up
    create_table :sitemizations do |t|
      t.integer :item_id
      t.integer :sitetype_id

      t.timestamps
    end
  end

  def self.down
    drop_table :sitemizations
  end
end
