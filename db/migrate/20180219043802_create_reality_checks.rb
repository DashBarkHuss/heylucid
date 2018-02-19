class CreateRealityChecks < ActiveRecord::Migration[5.1]
  def change
    create_table :reality_checks do |t|

      t.timestamps
    end
  end
end
