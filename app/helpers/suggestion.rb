class Suggestion

attr_reader :url_analysis, :suggested_sources, :urls

  def initialize(url_analysis_klass=UrlAnalysis, urls=Array.new)
    @url_analysis = url_analysis_klass
    @suggested_sources = {}
    @urls = urls
  end

  def news_source
    @url_analysis = url_analysis.new(urls)
    bias_eliminator(url_analysis.political_leaning_perc)
    # .keep_if{|source| calculate_matches(source)}
  end

  def bias_eliminator(current_score)
    score_needed =
      if current_score < 0
        100 - current_score
      else
        100 + current_score
      end
    score_needed
    # url_analysis.political_leaning_perc + .papers[source] / (news_source_list.size + 1) == 0
  end

  # def topic
  # a method to find out the keywords to give to the google news api
  # end

end
