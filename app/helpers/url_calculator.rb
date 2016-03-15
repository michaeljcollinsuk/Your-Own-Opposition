
class UrlCalculator

  attr_reader :papers

  attr_accessor :analysed_urls

  def initialize(user_urls=[])
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
    @analysed_urls = {}
    @user_urls = user_urls
  end


  #
  def url_analyser(url)
    url.split(".").map!{|keyword| keyword.to_sym}.keep_if{|news_source| papers.has_key? news_source}
  end

  def leniency(url_array)
    url_array.each{|url| url_analyser(url)}
  end

end

# return {daily_mail: 1} if url.include?('dailymail')
