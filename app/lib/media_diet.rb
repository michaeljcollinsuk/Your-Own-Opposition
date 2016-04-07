class MediaDiet

attr_reader :components
attr_accessor :composition

  def initialize(source_or_topic)
    @composition = Hash.new
    @components = source_or_topic
  end

  def analyse_composition
    components.each do |keyword|
      composition[keyword] = component_percentage(keyword).to_i
    end
  end

private

  def component_percentage(keyword)
    quantity = components.select{|matcher| keyword == matcher}.size
    (quantity.to_f / components.size.to_f) * 100
  end

end
