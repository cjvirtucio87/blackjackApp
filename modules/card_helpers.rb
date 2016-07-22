module GameClasses
  
  class Card
    attr_reader :value

    SUITS = %w{ h s c d }
    RANKS = %w{ a 2 3 4 5 6 7 8 9 10 j q k }

    def initialize(idx)
      @value = [SUITS[idx%3],RANKS[idx%12]]
    end

    def compute
      r = @value[1]
      return r.to_i if !!(/\d/.match(r))
      return 'a' if r == 'a'
      10
    end

  end

  class Deck
    attr_reader :cards

    def initialize
      @cards = (0..51).to_a.shuffle.map { |i| Card.new(i) }
    end

    def get_card
      @cards.pop
    end

  end

end