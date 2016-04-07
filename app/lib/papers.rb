#COULD WE MAKE THIS A MODEL?

class Papers

attr_reader :list

  def initialize
    @list = {dailymail: 100,
              telegraph: 80,
              bbc: 5,
              theguardian: -100,
              mirror: -80,
              sun: 100,
              huffington_post: -40,
              buzzfeed: -20,
              independent: -20,
              thetimes: 60,
              express: 20,
              morningstar: -60}
  end

end
