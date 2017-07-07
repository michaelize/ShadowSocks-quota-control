class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
        t.belongs_to :user, index: true
        t.integer :quota_cycle, null: false, default: '30'
        t.integer :quota_bytes, limit: 8, null: false, default: '5368709120'
        t.integer :used_quota, limit: 8, null: false, default: '0'
        t.datetime :origin_time
        t.timestamps null: false
    end
  end
end
