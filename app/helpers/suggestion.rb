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
      # require 'pry'; binding.pry
      find_many_suggestions(score_needed, papers)
    else
      @suggested_sources = {political_jolt: matches}
      matches
    end
  end

  def find_many_suggestions(score_needed, papers)
    shortlist = filter_sources(score_needed, papers)
    # require 'pry'; binding.pry

    @suggested_sources =
      shortlist.each{|source, rating| shortlist[source] = score_needed / rating}
    suggested_sources
  end

  def left_needed?(score_needed)
    score_needed < 0
  end

  def filter_sources(score_needed, papers)
    bias_needed = left_needed?(score_needed) ? :left : :right
    if bias_needed == :left
      papers.select{|source, rating| rating < 0 && rating > score_needed}
    else
      papers.select{|source, rating| rating > 0 && rating < score_needed}
    end
  end



end
