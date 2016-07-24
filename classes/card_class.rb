module GameClasses
  
  class Card
    attr_reader :value

    SUITS = %w{ h s c d }
    RANKS = %w{ a 2 3 4 5 6 7 8 9 10 j q k }

    def initialize(suit,rank)
      @value = [suit,rank]
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

    def initialize(cards)
      @cards = to_deck(cards) || new_deck
      @cards.shuffle
    end

    def get_card
      @cards.pop
    end

    private
      def to_deck(cards)
        return if cards.nil?
        @cards = cards.map do |card|
          Card.new(card[0],card[1])
        end
      end

      def new_deck
        out = []
        Card::SUITS.each do |suit|
          Card::RANKS.each do |rank|
            out.push Card.new(suit,rank)
          end
        end
        out
      end

  end

end