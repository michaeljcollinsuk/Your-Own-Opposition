class AddDetailsToAnalysis < ActiveRecord::Migration
  def change
    add_column :analysis, :bias_score, :integer
  end
end
