class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :location
      t.string :address
      t.string :city
      t.string :state
      t.string :user_type
      t.string :password_digest

      t.timestamps
    end
  end
end
