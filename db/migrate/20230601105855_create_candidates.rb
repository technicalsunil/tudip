class CreateCandidates < ActiveRecord::Migration[6.0]
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :address

      t.timestamps
    end
  end
end
