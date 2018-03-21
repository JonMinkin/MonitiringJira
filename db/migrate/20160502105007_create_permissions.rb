class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :klass
      t.string :action
      t.timestamps null: false
    end
  end
end
