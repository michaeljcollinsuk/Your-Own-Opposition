class RenameAnalysisToAnalyses < ActiveRecord::Migration
  def change
    rename_table :analysis, :analyses
  end
end
