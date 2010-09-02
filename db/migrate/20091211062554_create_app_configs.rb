class CreateAppConfigs < ActiveRecord::Migration
  def self.up
    create_table :app_configs do |t|
      t.string :key, :null => false
      t.string :value
    end
    add_index :app_configs, :key
  end

  def self.down
    drop_table :app_configs
  end
end
