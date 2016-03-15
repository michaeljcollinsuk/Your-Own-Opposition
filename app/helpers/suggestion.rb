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
    if urls.length == 0 || current_score == 0
      :balanced
    else
    score_needed = (current_score * (urls.length + 1)) / urls.length
    find_suggestion(score_needed)
    end
  end



  def find_suggestion(score_needed)
    papers = url_analysis.papers
    matches = []
    papers.select{|source, rating| matches << source if rating == score_needed}
      if matches.length == 0
        return 'combo needed'
      else
        return matches.pop
      end
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
