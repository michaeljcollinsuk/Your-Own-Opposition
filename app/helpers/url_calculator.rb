
class UrlCalculator



  attr_reader :news_source_list, :papers, :user_urls

  def initialize(user_urls= [])
    @papers = {dailymail: :right,
              telegraph: :right,
              bbc: :center,
              guardian: :left,
              mirror: :left,
              sun: :right,
              huffington_post: :center_left,
              buzzfeed: :left,
              independent: :center_left,
              thetimes: :center_right}
    @news_source_list = []
    @user_urls = user_urls
  end


  def parse_history
    @news_source_list = user_urls.map!{|url| parse(url)}.flatten!
  end


  def parse(url)
    url.split(".").map!{|keyword| keyword.to_sym}.keep_if{|news_source| papers.has_key? news_source}
  end


end

# return {daily_mail: 1} if url.include?('dailymail')
