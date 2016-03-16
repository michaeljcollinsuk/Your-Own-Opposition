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
  end



  def political_leaning_scores
    recent_scores = []
    parse_source_history.each{|source| recent_scores << papers[source]}
    recent_scores
  end

  def parse_source_history
    @news_source_list = user_urls.map!{|url| parse_source(url)}.flatten!
    news_source_list
  end

  def parse_source(url)
    raw_url_array = url.split(/\W/).map!{|keyword| keyword.to_sym}

    raw_url_array.keep_if{|news_source| papers.has_key? news_source}
  end


  public

  attr_reader :user_urls, :papers, :media_diet, :news_source_list

  def political_leaning_perc
    (political_leaning_scores.inject(:+)) / news_source_list.length
  end

  def find_media_diet
    news_source_list.each do |source|
      quantity = news_source_list.select{|same_source| source == same_source}.size
      percentage = (quantity.to_f / news_source_list.size.to_f) * 100
      media_diet[source] = percentage.to_i
    end
    media_diet
  end

end
