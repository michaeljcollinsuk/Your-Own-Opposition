class Analysis < ActiveRecord::Base
  serialize :media_diet, Hash
  serialize :frequent_topics, Hash

  belongs_to :user
  validates_presence_of :user
  validates_presence_of :bias_score

end
