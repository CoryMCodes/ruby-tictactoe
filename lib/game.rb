require_relative './player.rb'

LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

class Game
  def initialize()
    @board = Array.new(10)
    @players = get_players
    @current_player_id = 0
  end

  def play()
    loop do 
      place_player_marker(current_player)
      if player_has_won?(current_player)
        puts "#{current_player.name} Wins!"
        print_board
        return
      elsif board_is_full?
        puts "It's a draw"
        print_board
        return
      end
    switch_players!
    end
  end


  private

  def player_has_won?(player)
    LINES.any? do |line|
      line.all? {|position| @board[position] == player.marker}
    end  
  end

  def print_board
    col_separator, row_separator = " | ", "--+---+--"
    label_for_position = lambda{|position| @board[position] ? @board[position] : position}
    
    row_for_display = lambda{|row| row.map(&label_for_position).join(col_separator)}
    row_positions = [[1,2,3], [4,5,6], [7,8,9]]
    rows_for_display = row_positions.map(&row_for_display)
    puts rows_for_display.join("\n" + row_separator + "\n")
  end

  def place_player_marker(player)
   position = player.select_position
   puts "#{player.name} (#{player.marker}) selects position #{position} "
   @board[position] = player.marker
  end

  def board_is_full?
    free_positions.empty?
  end

  def free_positions
    (1..9).select {|position| @board[position].nil?}
  end

  def switch_players!
    @current_player_id = other_player
  end

  def other_player
    1 - @current_player_id
  end

  def current_player
    @players[@current_player_id]
  end

  def get_players
    puts "Enter Player 1 Name"
    name_one = gets.chomp
    player_one = Player.new(name_one, self, "X")
    puts "Enter Player 2 Name"
    name_two = gets.chomp
    player_two = Player.new(name_two, self, "O")
    [player_one, player_two]
  end

end