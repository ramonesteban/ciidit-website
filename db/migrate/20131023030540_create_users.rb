class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :title
      t.string :user_type
      t.string :password_digest
      t.string :remember_token

      t.timestamps
    end
  end
end
