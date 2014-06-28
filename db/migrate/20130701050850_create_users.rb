class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
	  t.string :first_name
	  t.string :last_name
	  t.string :gender
	  t.date :dob
	  t.string :mobile
	  t.string :password
	  t.string :email	
      t.timestamps
    end
  end
end
