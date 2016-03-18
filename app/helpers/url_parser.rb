class UrlParser

  attr_reader :user_urls, :papers, :news_source_list, :topics_list


  def initialize(user_urls = [], papers)
    @user_urls = user_urls
    @papers = papers.list
    @news_source_list = parse_source_history
    @topics_list = parse_keywords_history
  end

  def parse_source_history
    user_urls.map{|url| parse_source(url)}.flatten
  end


  def parse_source(url)
    parse(url).keep_if{|news_source| papers.has_key? news_source}
  end

  def parse_keywords_history
    topics_list = user_urls.map{|url| parse(url)}.flatten - news_source_list
    topics_list.map!{|word| word.downcase}
  end

  def parse(url)
    url.gsub(/\d/, '').split(/\W/).delete_if { |keyword| irrelevant_keyword?(keyword)}.map!{|keyword| keyword.to_sym}
  end

  def irrelevant_keyword?(keyword)
    ignore_me_array = ['www', 'http', 'com', 'html', 'co']
    ignore_me_array.include?(keyword) || keyword.length <= 3
  end

end
