class BiasEliminator

  def initialize(political_leaning_perc)
    @score_needed = political_leaning_perc
  end
  #
  # def eliminate_bias
  #   if urls.length == 0 || current_bias == 0
  #     :balanced
  #   else
  #     score_needed = (current_bias * (urls.length + 1)) / urls.length
  #     find_suggestion(score_needed)
  #   end
  # end
  #

  #
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
  #
  # @score_needed = score_needed


end
