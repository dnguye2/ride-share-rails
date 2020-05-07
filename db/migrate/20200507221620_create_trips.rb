class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.bigint :driver_id
      t.bigint :passenger_id
      t.datetime :date
      t.bigint :rating
      t.bigint :cost
      t.timestamps
    end
  end
end
