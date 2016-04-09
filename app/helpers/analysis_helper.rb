module AnalysisHelper

  def retrieve_urls
    data = []
    urls = current_user.urls.all
    urls.each {|url| data << url.link}
    data
  end

  def save_to_user(analysis)
    current_user.analyses << Analysis.new(:media_diet => analysis.media_diet,
                                          :frequent_topics => analysis.frequent_topics,
                                          :bias_score => analysis.bias.political_leaning)
    current_user.save
  end
end
