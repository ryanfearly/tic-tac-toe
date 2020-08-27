# This is a command line version of Tic Tac Toe

class TicTacToe
  attr_accessor :top_left, :top_mid, :top_right, :mid_left, :mid_mid, :mid_right, :low_left, :low_mid, :low_right

  def initialize
    @top_left = ' '
    @top_mid = ' '
    @top_right = ' '
    @mid_left = ' '
    @mid_mid = ' '
    @mid_right = ' '
    @low_left = ' '
    @low_mid = ' '
    @low_right = ' '
  end

  def print_board
    puts "\n#{top_left}|#{top_mid}|#{top_right}\n-+-+-\n#{mid_left}|#{mid_mid}|#{mid_right}\n-+-+-\n#{low_left}|#{low_mid}|#{low_right}\n"
  end

  def self.instructions
    puts "\n\n----Welcome to Tic Tac Toe!----\n\n"
    puts "1|2|3\n-+-+-\n4|5|6\n-+-+-\n7|8|9\n\n"
    puts 'This is the board. To make a play, type in the number corresponding with the square you want to play'
    puts "Player 1 will Play X, Player 2 will play O\n\n"
  end

  def mark_square(mark, square_num)
    if lookup_square(square_num) == ' '
      case square_num
      when 1
        @top_left = mark
      when 2
        @top_mid = mark
      when 3
        @top_right = mark
      when 4
        @mid_left = mark
      when 5
        @mid_mid = mark
      when 6
        @mid_right = mark
      when 7
        @low_left = mark
      when 8
        @low_mid = mark
      when 9
        @low_right = mark
      else
        puts 'Error - you did not enter a number'
      end
    else 'Square taken'
    end
  end

  def board_full?
    [@top_left, @top_mid, @top_right, @mid_left, @mid_mid, @mid_right, @low_left, @low_mid, @low_right].none?(' ')
  end

  def game_over?
    game_won? || board_full?
  end

  private

  def lookup_square(square_num)
    squares = [@top_left, @top_mid, @top_right, @mid_left, @mid_mid, @mid_right, @low_left, @low_mid, @low_right]
    squares[square_num - 1]
  end

  def three_in_a_row?(square1, square2, square3)
    (square1 == square2) && (square2 == square3) &&
      [square1, square2, square3].none?(' ')
  end

  def game_won?
    three_in_a_row?(top_left, top_mid, top_right) || # top row
      three_in_a_row?(mid_left, mid_mid, mid_right) || # middle row
      three_in_a_row?(low_left, low_mid, low_right) || # bottom row
      three_in_a_row?(top_left, mid_left, low_left) || # left column
      three_in_a_row?(top_mid, mid_mid, low_mid) || # mid column
      three_in_a_row?(top_right, mid_right, low_right) || # right column
      three_in_a_row?(top_left, mid_mid, low_right) || # diagonal with top left
      three_in_a_row?(top_right, mid_mid, low_left) # diagonal with top right
  end
end

# GAME PLAY
TicTacToe.instructions
game = TicTacToe.new
current_player = 'Player 1 (X)'

until game.game_over?
  puts "\n#{current_player}, make your play"
  choice = gets.chomp.to_i # Get square
  mark = current_player == 'Player 1 (X)' ? 'X' : 'O' # Set mark
  if game.mark_square(mark, choice) == 'Square taken'
    puts 'Square taken'
    next
  else game.mark_square(mark, choice)
  end

  game.print_board
  last_played = current_player
  current_player = last_played == 'Player 1 (X)' ? 'Player 2 (O)' : 'Player 1 (X)'
end

if game.board_full?
  puts "It's a draw!"
else puts "#{last_played} wins!"
end
