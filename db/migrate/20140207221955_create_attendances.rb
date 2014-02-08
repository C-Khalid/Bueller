class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.boolean :attendance
      t.date :attended_on
      t.timestamp :now
      t.integer :seat
      t.timestamps
    end
  end
end
