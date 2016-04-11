class SourceSuggestion

attr_reader :requirements

  def initialize(bias_eliminator)
    @requirements = bias_eliminator
  end

  def recommend_reading
    recommended_sources.each do |source, rating|
      recommended_sources[source] = suggest_quantity_to_read(rating)
    end
    recommended_sources
  end

  def top_source
    recommend_reading.min_by{ |source, quantity| quantity }
  end

  private

  def suggest_quantity_to_read(rating)
    (score_to_match / rating).abs
  end

  def recommended_sources
    requirements.filtered_sources
  end

  def score_to_match
    requirements.score_needed
  end

end
