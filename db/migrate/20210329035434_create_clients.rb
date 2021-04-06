class CreateClients < ActiveRecord::Migration[6.1]
  def change
    create_table :clients do |t|
      t.string :firstname
      t.string :lastname
      t.date :dateofbirth
      t.string :address
      t.string :state
      t.integer :zipcode
      t.string :phonenumber
      t.datetime :lastappointment
      t.datetime :nextappointment
      t.text :notes
      t.integer :clientof

      t.timestamps
    end
  end
end
