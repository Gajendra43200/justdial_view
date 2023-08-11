class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :service_name
      t.string :location
      t.string :city
      t.integer :avg_rating
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
