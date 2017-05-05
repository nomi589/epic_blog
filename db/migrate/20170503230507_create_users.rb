class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username, :password_digest, :first_name, :last_name, :email

      t.timestamps
    end
  end
end
