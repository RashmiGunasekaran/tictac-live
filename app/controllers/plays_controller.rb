class PlaysController < ApplicationController
  def new
    @play = Play.new
  end
  def create
    @play = Play.new(play_params)
    if @play.save
      redirect_to @play
    end
  end

  def update
    @play= Play.find(params[:id])
    if @play.positions.empty?
      @play.update_attributes(play_params)
    else
      @play.positions["X"]<<play_params[:positions]["X"]
    end

    if @play.level=="easy"
      auto_player(@play)
    else
      strategic_player(@play)
    end
  end

  def index
  end

  def show
    @play= Play.find(params[:id])
  end

  def edit
  end

  def strategic_player play
    if play.positions["X"].length<3
    auto_player play
    else
     new_pos=15-play.positions["O"].sum
     all_pos=play.positions["X"].concat(play.positions["O"])
     all_pos.flatten.map(&:to_i).include?(new_pos) ? check_al(play) : play.positions["O"]<<new_pos
    end

  end

  def check_sides play
    case play.positions["O"]
    when play.positions["O"].include?(9) && play.positions["O"].include?(7)
      play.positions["O"]<< 8
    when play.positions["O"].include?(9) && play.positions["O"].include?(8)
      play.positions["O"]<< 7
    when play.positions["O"].include?(9) && play.positions["O"].include?(7)
      play.positions["O"]<< 8
    when play.positions["O"].include?(9) && play.positions["O"].include?(6)
      play.positions["O"]<< 3
    when play.positions["O"].include?(9) && play.positions["O"].include?(3)
      play.positions["O"]<< 6
    when play.positions["O"].include?(7) && play.positions["O"].include?(8)
      play.positions["O"]<< 9
    when play.positions["O"].include?(7) && play.positions["O"].include?(1)
      play.positions["O"]<< 4
    when play.positions["O"].include?(7) && play.positions["O"].include?(4)
      play.positions["O"]<< 1
    when play.positions["O"].include?(3) && play.positions["O"].include?(6)
      play.positions["O"]<< 9
    when play.positions["O"].include?(3) && play.positions["O"].include?(1)
      play.positions["O"]<< 2
    when play.positions["O"].include?(3) && play.positions["O"].include?(2)
      play.positions["O"]<< 1
    when play.positions["O"].include?(1) && play.positions["O"].include?(2)
      play.positions["O"]<< 3
    when play.positions["O"].include?(1) && play.positions["O"].include?(4)
      play.positions["O"]<< 7
    end
  end

  def auto_player play
    p1 =play.positions["X"].flatten().map(&:to_i)
    tac = ([*1..9]-p1).sample
    if play.positions.has_key?("O")
      play.positions["O"]<<tac
    else
    play.positions.update({"O"=>[tac]})
    end

    if play.save!
      p2=play.positions["O"]
      if play.positions["X"].count >=3
        won?(p1)
      end
    end

  end


  def won? play_positions
    summation =[]
    for i in 0..5 do
      play_positions.combination(i).each do |combination|
      summation.push(combination) if combination.sum == 15
    end
    end
    win_position1=[1,2,3]
    win_position2=[1,4,7]
    win_position3=[3,6,9]
    win_position4=[7,8,9]
    win_position5=[1,5,9]
    win_position6=[3,5,7]
    win_position7=[4,5,6]
    win_position8=[2,4,8]
    if (play_positions.count=3 && play_positions.um==15) || ((play_positions&win_position1)==win_position1) || ((play_positions&win_position2)==win_position2) || ((play_positions&win_position3)==win_position3)
      return true
    elsif summation.include?(win_position5 || win_position6 || win_position7 || win_position8)
      return true
    else
      return false
    end
  end

  def destroy
    @play= Play.find(params[:id])
    @play.positions={}
    @play.save!
  end

  def play_params
    params.permit(:name, :email, :level, :positions => {})
  end
end
