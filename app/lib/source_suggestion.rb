class SourceSuggestion

attr_reader :requirements, :best_source, :recommended_reading

  def initialize(bias_eliminator)
    @requirements = bias_eliminator
    @recommended_reading = recommend_reading
    @best_source = find_best_suggestion
  end

private

  def recommend_reading
    recommended_sources.each do |source, rating|
      recommended_sources[source] = suggest_quantity_to_read(rating)
    end
    recommended_sources
  end

  def suggest_quantity_to_read(rating)
    (score_to_match / rating).abs
  end

  def find_best_suggestion
    recommended_reading.min_by{|source, quantity| quantity}
  end

  def recommended_sources
    requirements.filtered_sources
  end

  def score_to_match
    requirements.score_needed
  end

end
