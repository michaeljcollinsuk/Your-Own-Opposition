class AddMoreDetailsToAnalysis < ActiveRecord::Migration
  def change
    add_column :analysis, :media_diet, :text
    add_column :analysis, :frequent_topics, :text
  end
end
