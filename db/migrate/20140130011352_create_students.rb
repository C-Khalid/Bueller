class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :nickname
      t.string :email
      t.string :imageurl
      t.string :password_digest
      add_column :entries, :password_digest, :string
      t.timestamps
    end
  end
end
