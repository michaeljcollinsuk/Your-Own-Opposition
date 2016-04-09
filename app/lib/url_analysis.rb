
class UrlAnalysis

  attr_reader :url_parser, :media_diet, :bias, :frequent_topics

  def initialize(user_urls=Array.new, url_parser=UrlParser)
    @url_parser = url_parser.new(user_urls)
    @media_diet = media_diet_calculations(sources_to_analyse)
    @frequent_topics = media_diet_calculations(topics_to_analyse)
    @bias = retrieve_bias(sources_to_analyse)
  end

  def sources_to_analyse
    url_parser.news_source_list
  end

  def topics_to_analyse
    url_parser.topics_list
  end

  def media_diet_calculations(to_analyse)
    data = new_media_diet(to_analyse)
    data.analyse_composition
    data.composition
  end

  def retrieve_bias(to_analyse)
    new_media_diet(to_analyse).current_bias
  end

  def new_media_diet(to_analyse, diet_calculator=MediaDiet)
    diet_calculator.new(to_analyse)
  end

end
