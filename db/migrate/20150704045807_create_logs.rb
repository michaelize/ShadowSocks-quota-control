class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
        t.references :user
    	t.belongs_to :user, index: true
    	t.datetime :start_time, null: false
    	t.datetime :end_time, null: false, default: '1970-01-01 00:00:00'
    	t.inet     :trusted_ip
    	t.integer  :trusted_port
    	t.inet     :remote_ip
    	t.string  :remote_netmask
    	t.string  :protocol
    	t.integer :bytes_received, limit: 8, default: 0
    	t.integer :bytes_sent, limit: 8, default: 0
    	t.integer :total_used, limit: 8, default: 0
    	t.integer :status, default: 1
      	t.timestamps null: false
    end
  end
end
