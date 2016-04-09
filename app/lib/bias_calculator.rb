class BiasCalculator

  attr_reader :political_leaning, :papers, :bias_message, :sources_read

  def initialize(sources_read, papers=Papers.new)
    @papers = papers.list
    @sources_read = sources_read
    @political_leaning = calculate_leaning
    @bias_message = match_bias_message
  end

  def calculate_leaning
    political_leaning_scores.inject(:+) / sources_read.length
  end

  def political_leaning_scores
    sources_read.map{|source| papers[source]}
  end

  def match_bias_message(messages=Messages.new)
    messages.list.select {|score_range| score_range === political_leaning}.values[0]
  end

end
