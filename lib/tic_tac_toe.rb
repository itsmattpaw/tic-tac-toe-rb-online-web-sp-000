
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player = "X")
  board[index] = current_player
end

def position_taken2?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken2?(board, index)
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if space != " "
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  count = turn_count(board)
  count%2 == 0 ? "X" : "O"
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index)
    display_board(board)
  else
    turn(board)
  end
end

def position_taken?(board, index)
  (board[index] == "X" || board[index] == "O")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  #horizontal wins
  [0,1,2],
  [3,4,5],
  [6,7,8],
  #vertical wins
  [0,3,6],
  [1,4,7],
  [2,5,8],
  #diagonal wins
  [0,4,8],
  [2,4,6]
]


def won?(board)
  for win_combination in WIN_COMBINATIONS
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 =="X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 =="O" && position_2 == "O" && position_3 == "O"
      return win_combination
    else
      next
    end
  end
  return false
end

def full?(board)
  count = 0
  until count >= 9
    if position_taken?(board, count) != true
      return false
    else
      count += 1
    end
  end
  return true
end

def draw?(board)
  if won?(board) == false && full?(board) == true
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) != false || draw?(board) == true
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
    won?(board).each do |i|
      if board[i] == "X"
        return "X"
      else
        return "O"
      end
    end
  else
    return nil
  end
end
finsihed = false

def play(board)
  while over? == false
    turn(board)
    if over? == true
      if(winner == "X")
        puts "Congragulations X"
      elsif(winner == "O")
        puts "Congragulations O"
      else
        "Cat's Game!"
      end
    end
  end
end
