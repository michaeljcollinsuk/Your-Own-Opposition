class Suggestion

  attr_accessor :suggestion_requirements
  attr_reader :best_source, :recommended_reading

  def initialize(url_analysis, bias_eliminator=BiasEliminator)
    @suggestion_requirements = bias_eliminator.new(url_analysis.bias_score)
    @best_topic = topic_suggestion(url_analysis.frequent_topics)
    @recommended_reading = recommend_reading
    @best_source = top_source
  end

  private

  def topic_suggestion(frequent_topics)
    frequent_topics.max_by{|keyword, percentage| percentage}
  end

  def recommend_reading
    required_sources.each do |source, rating|
      required_sources[source] = suggest_quantity_to_read(rating)
    end
    required_sources
  end

  def top_source
    recommended_reading.min_by{ |source, quantity| quantity }
  end

  def suggest_quantity_to_read(rating)
    (score_to_match / rating).abs
  end

  def required_sources
    suggestion_requirements.filtered_sources
  end

  def score_to_match
    suggestion_requirements.score_needed
  end

end
