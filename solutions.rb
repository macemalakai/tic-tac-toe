# 1. Display the initial empty 3x3 board.
# 2. Ask the user to mark a square.
# 3. Computer marks a square.
# 4. Display the updated board state.
# 5. If winner, display winner.
# 6. If board is full, display tie.
# 7. If neither winner nor board is full, go to #2.
# 8. Play again?
# 9. If yes, go to #1.
# require 'pry'

$player_name = ""
INITIAL_MARKER = " "
PLAYER_MARKER = "X"
COMPUTER_MARKER = "O"
WINNING_COMBOS = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                  [1, 4, 7], [2, 5, 8], [3, 6, 9],
                  [1, 5, 9], [3, 5, 7]]

def prompt(msg)
  puts "=> #{msg}"
end

 def get_name
   system 'clear'
   prompt "Hey there! What's your name?"
   $player_name = gets.chomp
   return $player_name
 end

 get_name

def display_board(brd)
  system 'clear'
    prompt "#{$player_name}, you are '#{PLAYER_MARKER}', Computer is '#{COMPUTER_MARKER}'."
  puts ""
  puts "     |     |     "
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}  "
  puts "     |     |     "
  puts ""
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_places_piece!(brd)
  square = ""
  loop do
    prompt "Please choose a square: (#{empty_squares(brd).join(", ")})"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Please choose a valid square."
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  if brd[5] == INITIAL_MARKER
    brd[5] = COMPUTER_MARKER
  else
    square = empty_squares(brd).sample
    brd[square] = COMPUTER_MARKER
  end
end

def board_is_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_COMBOS.each do |combo|
    if brd.values_at(*combo).count(PLAYER_MARKER) == 3
        return "#{$player_name}"
    elsif brd.values_at(*combo).count(COMPUTER_MARKER) == 3
      return "Computer"
    end
  end
  nil
end

#get_name Running the method outside of the loop, as I only need it the once. Though, every new game should have it... I suppose.

loop do
  ttt_board = initialize_board
  display_board(ttt_board)

  loop do
    player_places_piece!(ttt_board)
    display_board(ttt_board)
    computer_places_piece!(ttt_board)
    display_board(ttt_board)
    break if board_is_full?(ttt_board) || someone_won?(ttt_board)
  end

  if board_is_full?(ttt_board) && !someone_won?(ttt_board)
    prompt "It's a tie!"
  else
    prompt "#{detect_winner(ttt_board)} wins!"
  end

  answer = ""
    prompt "Would you like to play again, #{$player_name}? (Yes or no)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing! #{$player_name}"
