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
      find_many_suggestions(score_needed, papers)
    else
      matches
    end
  end

  def find_many_suggestions(score_needed, papers)

  end


  # def topic
 # a method to find out the keywords to give to the google news api
end
