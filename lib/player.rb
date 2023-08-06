require_relative 'game.rb'

class Player
  attr_accessor :name, :marker
  
  def initialize(name, game, marker)
    self.name = name
    self.marker = marker
    @game = game
  end

  def select_position
    @game.print_board
    loop do 
      print "#{name}(#{marker}) select your position (1-9):"
      selection = gets.to_i 
      return selection if @game.free_positions.include?(selection)
      puts "Position #{selection} is not available. Please Try Again"
    end
  end
end