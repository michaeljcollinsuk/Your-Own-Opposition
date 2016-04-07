class BiasCalculator

  attr_reader :political_leaning, :sources_read, :papers

  def initialize(sources_read, papers)
    @sources_read = sources_read
    @papers = papers
    @political_leaning = political_leaning_percentage
    @bias_message = match_bias_message
  end

  def political_leaning_percentage
    political_leaning_scores.inject(:+) / sources_read.length
  end

  def political_leaning_scores
    sources_read.map{|source| papers[source]}
  end

  def match_bias_message
    message =
    case political_leaning
      when -100..-80 then "You're a Corbynista Commie"
      when -80..-50 then "You un-washed hippie bastard"
      when -50..-20 then "leaning to the Loony Left"
      when -10..10 then "sitting on the fence"
      when 10..20 then "I'm not racist but..."
      when 20..50 then "benefit-scrounger blamer"
      when 50..80 then "Cameron isn't a pig-fucker in your eyes"
      when 80..100 then "Trump-loving bum-trumpet"
    end
    message
  end
end
