class Messages

attr_reader :list

  def initialize
    @list = {-100..-80 => :"Corbynista Commie",
             -80..-50 => :"#FeelTheBern Bernista",
             -50..-20 => :"Un-washed Hippie Bastard",
             -20..-10 => :"Loony Left Leaner",
             -10..10 => :"Fence Sitter",
             10..20 => :"I'm not Racist but...",
             20..50 => :"Benefit-Scrounger Blamer",
             50..80 => :"Cameron is Peppa Pig's Best Friend",
             80..100 => :"Trump-Loving Bum-Trumpet"}
  end

end
