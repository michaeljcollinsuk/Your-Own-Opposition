
class Analysis

  attr_reader :url_parser, :media_diet, :bias

  def initialize(user_urls=Array.new, url_parser=UrlParser, media_diet_analysis= MediaDiet)
    @url_parser = url_parser.new(user_urls)
    @media_diet = media_diet_analysis.new(sources_to_analyse)
    @frequent_topics = media_diet_analysis.new(topics_to_analyse)
    @bias = bias_calculator
  end


  def sources_to_analyse
    url_parser.news_source_list
  end

  def topics_to_analyse
    url_parser.topics_list
  end



end
