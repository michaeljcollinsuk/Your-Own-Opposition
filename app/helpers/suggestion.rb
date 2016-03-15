class Suggestion

attr_reader :url_analysis, :suggested_sources, :urls

  def initialize(url_analysis_klass=UrlAnalysis, urls=Array.new)
    @url_analysis = url_analysis_klass
    @suggested_sources = {}
    @urls = urls
  end

  def news_source
    @url_analysis = url_analysis.new(urls)
    eliminate_bias(url_analysis.political_leaning_perc)
  end

  def eliminate_bias(current_score)
    score_needed =
      if urls.length == 0
        0
      else
      (current_score * (urls.length + 1)) / urls.length
      end
    find_suggestions(score_needed)
    # url_analysis.political_leaning_perc + .papers[source] / (news_source_list.size + 1) == 0
  end



  def find_suggestions(score_needed)
  #   papers = url_analysis.papers
  #   if leaning == :right
  #     right_leaning = papers.keys.keep_if{|source| papers[source] > 0}
  #     #an array of all the right=wing papers names
  #     right_leaning.map{|source| papers[source].gcd(score_needed)}
  #     #an array of all the lowest common multiples
  #     #find the right paper sources and quantity needed
  #   else
  #     #find the left paper sources and quantity needed to get average
  #   end
  end
  #
  # def left?(current_score)
  #   return current_score < 0 ? true : false
  # end

  # def topic
 # a method to find out the keywords to give to the google news api
end
