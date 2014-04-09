class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.column :user_name, :string , :null=> false
    	t.column :pwd, :string , :null=> false
      t.timestamps
    end
  end

  def self.down 
    	drop_table :users
  end

end
