class ChangePhoneNumType < ActiveRecord::Migration[6.0]
  def change
    change_column :passengers, :phone_num, :string
  end
end
