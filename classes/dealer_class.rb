module GameClasses

  class Dealer

    def initialize(cards=nil,player_hand=nil,dealer_hand=nil)
      @deck = Deck.new(cards)
      @player_hand = to_cards(player_hand) || new_hand
      @dealer_hand = to_cards(dealer_hand) || new_hand
    end

    def to_cards(hand)
      return if hand.nil?
      hand.map { |card| Card.new(card[0],card[1]) }
    end

    def new_hand
      [@deck.get_card,@deck.get_card]
    end

    def parse_player_hand
      @player_hand.map(&:value)
    end

    def parse_dealer_hand
      @dealer_hand.map(&:value)
    end

    def parse_deck
      @deck.cards.map do |card|
        card.value
      end
    end

    def hit
      @player_hand.push @deck.get_card
    end

    def bust?
      get_player_points > 21
    end

    def stay
      until (get_dealer_points >= 17) || (get_dealer_points >= 21)  
        @dealer_hand.push @deck.get_card
      end
      win?
    end

    private

      def win?
        return true if dealer_bust?
        p_pts = get_player_points
        d_pts = get_dealer_points
        (p_pts > d_pts) && (p_pts <= 21)
      end

      def dealer_bust?
        get_dealer_points > 21
      end

      def get_player_points
        cards = @player_hand
        aces = []
        pts = calculate_points(cards,aces)
        return pts if aces.empty?
        get_ace_points(aces,pts)
      end

      def get_dealer_points
        cards = @dealer_hand
        aces = []
        pts = calculate_points(cards,aces)
        return pts if aces.empty?
        get_ace_points(aces,pts)
      end

      def calculate_points(cards,aces)
        cards.reduce(0) do |m,c|         
          v = c.compute
          case v
          when 'a'
            aces.push c
            0
          when 'j','k','q'
            m + 10
          when Fixnum
            m + v
          end
        end
      end

      def get_ace_points(aces,points)
        aces.reduce(points) do |m,a|
          if m + 11 > 21
            m += 1
          else
            m += 11
          end
        end
      end

  end

end

