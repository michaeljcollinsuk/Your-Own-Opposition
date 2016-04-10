class BiasEliminator

  attr_accessor :score_needed, :bias_score
  attr_reader :filtered_sources

  def initialize(bias_score)
    @bias_score = bias_score
    @score_needed = calculate_score_needed
    @filtered_sources = filter_sources
  end

  def new_source_suggester(source_suggestion=SourceSuggestion)
    source_suggestion.new(score_needed, filtered_sources)
  end

  def calculate_score_needed
    already_balanced? ? :balanced : bias_score * -1
  end

  def filter_sources
    unless already_balanced?
      papers.select {|source, rating| need_left? ? left(rating) : right(rating)}
    else
      :balanced
    end
  end

  def papers(sources=Papers.new)
    sources.list
  end


  private

  def already_balanced?
    bias_score == 0 || score_needed == :balanced
  end

  def need_left?
    score_needed < 0
  end

  def left(rating)
    rating < 0 && rating >= score_needed
  end

  def right(rating)
    rating > 0 && rating <= score_needed
  end

end
