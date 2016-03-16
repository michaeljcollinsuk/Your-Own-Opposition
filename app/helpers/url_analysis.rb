private

class UrlAnalysis

  attr_reader :news_source_list

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
    @aggregated_news_source_list = Hash.new
  end



  def political_leaning_scores
    recent_scores = []
    parse_history.each{|source| recent_scores << papers[source]}
    recent_scores
  end

  def parse_history
    @news_source_list = user_urls.map!{|url| parse(url)}.flatten!
    news_source_list
  end

  def parse(url)
    url.split(".").map!{|keyword| keyword.to_sym}
                  .keep_if{|news_source| papers.has_key? news_source}
  end

  public

  attr_reader :user_urls, :papers, :aggregated_news_source_list

  def political_leaning_perc
    (political_leaning_scores.inject(:+)) / news_source_list.length
  end

end
