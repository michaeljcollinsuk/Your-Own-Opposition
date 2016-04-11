class Suggestion

  attr_reader :suggestion_requirements

  def initialize(url_analysis)
    @suggestion_requirements = new_suggestion_requirements(url_analysis.bias_score)
    @best_source = source_suggestion.top_source
    @recommended_reading = source_suggestion.recommend_reading
    @best_topic = topic_suggestion(url_analysis.frequent_topics)
  end

  def new_suggestion_requirements(bias_score, bias_eliminator=BiasEliminator)
    bias_eliminator.new(bias_score)
  end

  def source_suggestion
    suggestion_requirements.new_source_suggester
  end

  def topic_suggestion(frequent_topics)
    frequent_topics.max_by{|keyword, percentage| percentage}
  end

end
