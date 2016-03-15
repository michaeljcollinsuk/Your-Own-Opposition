
class UrlCalculator

  attr_reader :papers

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
              the_times: :center_right}
    @analysed_papers = {}
    @user_urls = user_urls
  end



# def url_analyser(url)
#   papers.each do | paper, stance |
#     return paper if paper.include? url
#   end
# end


end

# return {daily_mail: 1} if url.include?('dailymail')
