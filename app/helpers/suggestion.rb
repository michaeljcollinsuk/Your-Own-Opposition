class Suggestion

attr_reader :url_analysis, :suggested_sources, :urls, :current_bias, :topic_suggestions

  def initialize(url_analysis_klass=UrlAnalysis, urls=Array.new)
    @url_analysis = url_analysis_klass.new(urls)
    @suggested_sources = Hash.new
    @urls = urls
    @current_bias = url_analysis.political_leaning_perc
    @topic_suggestions = []
  end

  def make_suggestion
    suggest_topic
    eliminate_bias
  end

  # def news_source
  #   # @current_bias = url_analysis.political_leaning_perc
  #   suggest_topic
  #   eliminate_bias
  # end

  def suggest_topic
    top_topics = url_analysis.top_topics
    perc_threshold = top_topics.values.sort![3]
    top_topics.each{|topic, perc| @topic_suggestions << topic if perc > perc_threshold }
  end


  def eliminate_bias
    if urls.length == 0 || current_bias == 0
      :balanced
    else
    score_needed = (current_bias * (urls.length + 1)) / urls.length
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
      @suggested_sources = {political_jolt: matches}
      matches
    end
  end

  def find_many_suggestions(score_needed, papers)
    shortlist = filter_sources(score_needed, papers)
    @suggested_sources =
      shortlist.each do |source, rating|
        quantity = (score_needed / rating).abs
        shortlist[source] = quantity > 1 ? quantity : nil
      end
    suggested_sources.select{|source, rating| rating != nil}
  end


  def filter_sources(score_needed, papers)
    bias_needed = left_needed?(score_needed) ? :left : :right
    if bias_needed == :left
      papers.select{|source, rating| rating < 0 && rating < score_needed}
    else
      papers.select{|source, rating| rating > 0 && rating > score_needed}
    end
  end

  def left_needed?(score_needed)
    score_needed > 0
  end



end
