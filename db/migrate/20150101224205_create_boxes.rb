class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.string :secure_id, null: false, index: { unique: true }
      t.json :params, null: false
    end
  end
end
