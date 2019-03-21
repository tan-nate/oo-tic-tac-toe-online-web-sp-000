class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end
  
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]
  
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
  
  def move(index, current_player)
    @board[index] = current_player
  end
  
  def position_taken?(location)
    @board[location] != " " && @board[location] != ""
  end
  
  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end
  
  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end
  
  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end
  
  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end
  end
  
  def won?
    game_win_combinations = WIN_COMBINATIONS.select do |win_combination|
      win_combination.all? {|win_index| @board[win_index] == "X"} ||
      win_combination.all? {|win_index| @board[win_index] == "O"}
    end
    if game_win_combinations == []
      game_win_combinations = false
    else
      game_win_combinations.flatten!
    end
    game_win_combinations
  end
  
  def full?
    (0..8).to_a.all? do |index|
      position_taken?(index)
    end
  end
  
  def draw?
    if !won? && full?
      true
    else
      false
    end
  end
  
  def over?
    if won? || draw? || full?
      true
    else
      false
    end
  end
  
  def winner
    if won?
      @board[won?[0]]
    else
      nil
    end
  end
  
  def play
    until over? do
      turn
    end
    
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end