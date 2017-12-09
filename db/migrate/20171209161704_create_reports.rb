class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.string :name
      t.string :type
      t.binary :data

      t.timestamps
    end
  end
end
