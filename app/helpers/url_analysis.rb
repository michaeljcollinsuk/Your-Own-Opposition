private

class UrlAnalysis


  def initialize(user_urls= [])
    @papers = {dailymail: 100,
              telegraph: 80,
              bbc: 5,
              theguardian: -100,
              mirror: -80,
              sun: 100,
              huffington_post: -40,
              buzzfeed: -20,
              independent: -20,
              thetimes: 60,
              dailyexpress: 20,
              morningstar: -60}
    @news_source_list = Array.new
    @user_urls = user_urls
    @media_diet = Hash.new
    @topics_list = Array.new
    @top_topics = Hash.new
  end



  def political_leaning_scores
    recent_scores = []
    parse_source_history.each{|source| recent_scores << papers[source]}
    recent_scores
  end

  def parse_source_history
    @news_source_list = user_urls.map{|url| parse_source(url)}.flatten
    parse_keywords_history
    news_source_list
  end

  def parse_source(url)
    parse(url).keep_if{|news_source| papers.has_key? news_source}
  end

  def parse_keywords_history
    @topics_list = user_urls.map{|url| parse(url)}.flatten - news_source_list
    topics_list.map!{|word| word.downcase}
  end

  def parse(url)
    url.gsub(/\d/, '').split(/\W/).delete_if { |keyword| irrelevant_keyword?(keyword)}.map!{|keyword| keyword.to_sym}
  end

  def irrelevant_keyword?(keyword)
    ignore_me_array = ['www', 'http', 'com']
    ignore_me_array.include?(keyword) || keyword.length < 2
    # keyword == :www || keyword == :http || keyword == :uk || keyword == :com ||
    # keyword == :com
  end

  public

  attr_reader :user_urls, :papers, :media_diet, :news_source_list, :topics_list, :top_topics

  def political_leaning_perc
    (political_leaning_scores.inject(:+)) / news_source_list.length
  end

  def find_media_diet(source_or_topic)
    media_analysed = (source_or_topic == news_source_list) ? media_diet : top_topics
    source_or_topic.each do |source|
      quantity = news_source_list.select{|same_source| source == same_source}.size
      percentage = (quantity.to_f / source_or_topic.size.to_f) * 100
      media_analysed[source] = percentage.to_i
    end
    media_analysed
  end



end
