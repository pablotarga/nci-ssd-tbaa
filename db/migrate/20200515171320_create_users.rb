class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.datetime :last_access_at
      t.string :last_access_ip
      t.datetime :current_access_at
      t.string :current_access_ip

      t.timestamps
    end
  end
end
