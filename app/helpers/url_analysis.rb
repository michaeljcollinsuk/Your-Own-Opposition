private

class UrlAnalysis

  def initialize(user_urls= Array.new)
    @papers = {dailymail: 100,
              telegraph: 80,
              bbc: 5,
              theguardian: -100,
              mirror: -80,
              thesun: 100,
              huffingtonpost: -40,
              buzzfeed: -20,
              independent: -20,
              thetimes: 60,
              express: 20,
              morningstaronline: -60}
    @user_urls = user_urls
    @news_source_list = parse_source_history
    @current_bias = political_leaning_perc
    @funny_bias_message = find_right_message
    @topics_list = parse_keywords_history
    @media_diet = find_media_diet(news_source_list)
    @top_topics = find_media_diet(topics_list)
    @top_topic = find_top_topic(top_topics)
  end



  def parse_source_history
    list =
    user_urls.map{|url| parse_source(url)}.flatten
    list
  end

  def political_leaning_perc
    (political_leaning_scores.inject(:+)) / news_source_list.length
  end

  def political_leaning_scores
    recent_scores = []
    news_source_list.each{|source| recent_scores << papers[source]}
    recent_scores
  end

  def find_right_message
    message =
    case political_leaning_perc
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

  def parse_source(url)
    parse(url).keep_if{|news_source| papers.has_key? news_source}
  end

  def parse_keywords_history
    @topics_list = user_urls.map{|url| parse(url)}.flatten - news_source_list
    find_media_diet(topics_list)
    @topics_list.map!{|word| word.downcase}
  end

  def parse(url)
    url.gsub(/\d/, '').split(/\W/).delete_if { |keyword| irrelevant_keyword?(keyword)}.map!{|keyword| keyword.to_sym}
  end

  def irrelevant_keyword?(keyword)
    ignore_me_array = ['www', 'http', 'com', 'html', 'co']
    ignore_me_array.include?(keyword) || keyword.length <= 3
  end

  def find_media_diet(source_or_topic)
    media_analysed = Hash.new
    source_or_topic.each do |source|
      quantity = source_or_topic.select{|same_source| source == same_source}.size
      percentage = (quantity.to_f / source_or_topic.size.to_f) * 100
      media_analysed[source] = percentage.to_i
    end
    media_analysed
  end

  def find_top_topic(top_topics)
    top_score = top_topics.values.sort[-1]
    top_topics.select{|key, value| key if value == top_score}
  end

  public

  attr_reader :user_urls, :papers, :media_diet, :news_source_list, :topics_list, :top_topics, :top_topic, :funny_bias_message

end
