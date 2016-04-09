class AddUserIdToAnalysis < ActiveRecord::Migration
  def change
    create_table :analysis do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.timestamps
    end
  end
end
