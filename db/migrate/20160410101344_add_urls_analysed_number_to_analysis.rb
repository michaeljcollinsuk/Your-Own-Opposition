class AddUrlsAnalysedNumberToAnalysis < ActiveRecord::Migration
  def change
    add_column :analyses, :number_urls_analysed, :integer
  end
end
