class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.string :cal_id
      t.string :event_id
      t.integer :uid

      t.timestamps
    end
  end
end
