class TicTacToe

  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5],  # Middle row
    [6,7,8], # Bottom row
    [0,4,8], # Right to left diagonal
    [2,4,6],  # Left to right diagonal
    [0,3,6],
    [1,4,7],
    [2,5,8],
  ]

  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, char)
    @board[index] = char
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    if index <= 9 && index >= 0
      !position_taken?(index)
    else
      false
    end
  end

  def turn(user_input = nil)
    user_input = user_input || gets.strip
    user_input = input_to_index(user_input)
    if valid_move?(user_input)
      move(user_input, current_player)
      display_board
    else
      turn
    end
  end

  def won?
    for comb in WIN_COMBINATIONS
      win_1 = comb[0]
      win_2 = comb[1]
      win_3 = comb[2]

      if ![@board[win_1], @board[win_2], @board[win_3]].any? { |e| e == " " }
         if @board[win_1] == @board[win_2] && @board[win_2] == @board[win_3]
           return comb
         end
      end
    end
    false
  end

  def full?
    !@board.any? { |empty_spot|  empty_spot == " "}
  end

  def draw?
    full? && !won?
  end

  def over?
    # returns t for won, draw or full
    draw? || won?
  end

  def winner
    # return the char that won
    index = won?

    if index
      return @board[index[0]]
    else
      return nil
    end
  end

  def play
    puts "1-9"
    user_input = gets.strip
    if !over?
      until turn_count == 9
        turn(user_input)
      end
    end
  end
end
