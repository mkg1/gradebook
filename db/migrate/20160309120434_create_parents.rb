class CreateParents < ActiveRecord::Migration
  def change
    create_table :parents do |t|
      t.string :name
      t.string :student_id
      t.string :email
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
