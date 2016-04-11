class Suggestion

  attr_reader :suggestion_requirements

  def initialize(url_analysis)
    @suggestion_requirements = new_suggestion_requirements(url_analysis.bias_score)
    @best_source = source_suggestion.top_source
    @multiple_sources = source_suggestion.recommended_reading
    @best_topic = topic_suggestion(url_analysis.frequent_topics)
  end

  def new_suggestion_requirements(bias_score, bias_eliminator=BiasEliminator)
    bias_eliminator.new(bias_score)
  end

  # def source_suggestion
  #   make_source_suggestion.crunch_numbers
  # end

  def make_source_suggestion
    suggestion_requirements.new_source_suggester
  end


  # def new_topic_suggester(frequent_topics, topic_suggestions=TopicSuggestion)
  #   topic_suggestions.new(frequent_topics)
  # end



  # def suggest_topic
  #   top_topics = url_analysis.top_topics
  #   perc_threshold = top_topics.values.sort![3]
  #   top_topics.each{|topic, perc| @topic_suggestions << topic if perc > perc_threshold }
  # end






  # def filter_sources(score_needed, papers)
  #   bias_needed = left_needed?(score_needed) ? :left : :right
  #   if bias_needed == :left
  #     papers.select{|source, rating| rating < 0 && rating < score_needed}
  #   else
  #     papers.select{|source, rating| rating > 0 && rating > score_needed}
  #   end
  # end
  #
  # def left_needed?(score_needed)
  #   score_needed > 0
  # end


  # :topic_suggestions



end
