
class Analysis

  def initialize(user_urls=Array.new)
    @current_bias = political_leaning_percentage(user_urls)
    @bias_message = match_bias_message
    @media_diet = diet_analysis(sources_to_analyse)
    @frequent_topics = diet_analysis(topics_to_analyse)
  end

  def url_parser(user_urls)
    UrlParser.new(user_urls)
  end

  # def sources_to_analyse
  #   url_parser.news_source_list
  # end
  #
  # def topics_to_analyse
  #   url_parser.topics_list
  # end

  def diet_analysis(source_or_topic)
    url_parser.extract_media_diet(source_or_topic)
  end

  def political_leaning_percentage
    (political_leaning_scores.inject(:+)) / sources_to_analyse.length
  end

  def political_leaning_scores
    recent_scores = []
    sources_to_analyse.each{|source| recent_scores << papers[source]}
    recent_scores
  end

  #
  # def match_bias_message
  #   message =
  #   case political_leaning_perc
  #     when -100..-80 then "You're a Corbynista Commie"
  #     when -80..-50 then "You un-washed hippie bastard"
  #     when -50..-20 then "leaning to the Loony Left"
  #     when -10..10 then "sitting on the fence"
  #     when 10..20 then "I'm not racist but..."
  #     when 20..50 then "benefit-scrounger blamer"
  #     when 50..80 then "Cameron isn't a pig-fucker in your eyes"
  #     when 80..100 then "Trump-loving bum-trumpet"
  #   end
  #   message
  # end

end

# private
#
# class Analysis
#
#   def initialize(user_urls= Array.new, url_type=Papers, url_parser=UrlParser)
#     @url_parser = url_parser.new(user_urls, url_type.new)
#     @papers = @url_parser.papers
#     @current_bias = political_leaning_perc
#     # @funny_bias_message = find_right_message
#     @media_diet = find_media_diet(sources_to_analyse)
#     @top_topics = find_media_diet(topics_to_analyse)
#   end
#
#
#   def sources_to_analyse
#     url_parser.news_source_list
#   end
#
#   def topics_to_analyse
#     url_parser.topics_list
#   end
#

#   #

#

#
#   public
#
#   attr_reader :current_bias, :papers, :media_diet, :url_parser, :top_topics, :top_topic, :funny_bias_message
#
# end
