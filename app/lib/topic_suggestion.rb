class TopicSuggestion

  def initialize
    @topic_suggestion = suggest_topic
  end


  def suggest_topic
    top_topics = url_analysis.top_topics
    perc_threshold = top_topics.values.sort![3]
    top_topics.each{|topic, perc| @topic_suggestions << topic if perc > perc_threshold }
  end

end
