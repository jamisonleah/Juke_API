class AddTrackables < ActiveRecord::Migration[6.0]
  def up
  
	change_table :users do |t|
 	 	t.integer  :sign_in_count, default: 0, null: false
		t.datetime :current_sign_in_at
		t.datetime :last_sign_in_at
		t.inet     :current_sign_in_ip
		t.inet     :last_sign_in_ip
	end
  end

  def down 
	
	change_table :users do |t|
 	 	t.remove :sign_in_count, default: 0, null: false
		t.remove :current_sign_in_at
		t.remove :last_sign_in_at
		t.remove :current_sign_in_ip
		t.remove :last_sign_in_ip
  	end

   end
end
