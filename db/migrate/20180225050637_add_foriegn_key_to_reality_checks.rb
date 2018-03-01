class AddForiegnKeyToRealityChecks < ActiveRecord::Migration[5.1]
  def change
  	 add_reference :reality_checks, :user, foreign_key: true
  end
end
