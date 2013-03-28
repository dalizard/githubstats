class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :actor
      t.string :type
      t.text :data
      t.datetime :github_created_at, null: false

      t.timestamps
    end
  end
end
