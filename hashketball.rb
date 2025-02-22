require "pry"

def game_hash
  {
    :home => 
      {
      :team_name => "Brooklyn Nets",
      :colors => ["Black", "White"],
      :players => 
        [
          {:player_name => "Alan Anderson", :number => 0, :shoe => 16, :points => 22, :rebounds => 12, :assists => 12, :steals => 3, :blocks => 1, :slam_dunks => 1},
          {:player_name => "Reggie Evans", :number => 30, :shoe => 14, :points => 12, :rebounds => 12, :assists => 12, :steals => 12, :blocks => 12, :slam_dunks => 7},
          {:player_name => "Brook Lopez", :number => 11, :shoe => 17, :points => 17, :rebounds => 19, :assists => 10, :steals => 3, :blocks => 1, :slam_dunks => 15},
          {:player_name => "Mason Plumlee", :number => 1, :shoe => 19, :points => 26, :rebounds => 11, :assists => 6, :steals => 3, :blocks => 8, :slam_dunks => 5},
          {:player_name => "Jason Terry", :number => 31, :shoe => 15, :points => 19, :rebounds => 2, :assists => 2, :steals => 4, :blocks => 11, :slam_dunks => 1}
        ]
      },
    :away => {
      :team_name => "Charlotte Hornets",
      :colors => ["Turquoise", "Purple"],
      :players => [
        {:player_name => "Jeff Adrien", :number => 4, :shoe => 18, :points => 10, :rebounds => 1, :assists => 1, :steals => 2, :blocks => 7, :slam_dunks => 2},
        {:player_name => "Bismack Biyombo", :number => 0, :shoe => 16, :points => 12, :rebounds => 4, :assists => 7, :steals => 22, :blocks => 15, :slam_dunks => 10},
        {:player_name => "DeSagna Diop", :number => 2, :shoe => 14, :points => 24, :rebounds => 12, :assists => 12, :steals => 4, :blocks => 5, :slam_dunks => 5},
        {:player_name => "Ben Gordon", :number => 8, :shoe => 15, :points => 33, :rebounds => 3, :assists => 2, :steals => 1, :blocks => 1, :slam_dunks => 0},
        {:player_name => "Kemba Walker", :number => 33, :shoe => 15, :points => 6, :rebounds => 12, :assists => 12, :steals => 7, :blocks => 5, :slam_dunks => 12}
        ]
    }
  }
end

def num_points_scored(player)
  game_hash.each do |team, info|
    info[:players].each do |stat_name|
      if stat_name[:player_name] == player
        return stat_name[:points]
      end
    end
  end
end

def shoe_size(player)
  game_hash.each do |team, info|
    info[:players].each do |stat_name|
      if stat_name[:player_name] == player
        return stat_name[:shoe]
      end
    end
  end
end

def team_colors(team)
  game_hash.each do |location, info|
    if team == info[:team_name]
      return info[:colors]
    end
  end
end

def team_names
  team_name_array = []
  game_hash.each do |location, info|
    team_name_array << info[:team_name]
  end
return team_name_array
end

def player_numbers(team_name)
  numbers_array = []
  if game_hash[:home][:team_name] == team_name
    game_hash[:home][:players].each do |key|
      numbers_array << key[:number]
    end
  elsif game_hash[:away][:team_name] == team_name
    game_hash[:away][:players].each do |key|
      numbers_array << key[:number]
    end
  end
return numbers_array
end

def stats_hash(player_hash)
  player_hash.tap { |hs| hs.delete(:player_name) }
  sorted_array = player_hash.sort 
  sorted_hash = {}
  counter = 0
  while counter < sorted_array.length
    key = sorted_array[counter][0]
    index = sorted_array[counter][1]
    sorted_hash[key] = index
  counter += 1
  end
  # binding.pry
  return sorted_hash
end

def combine_players(hash)
  home_players = hash[:home][:players]
  away_players = hash[:away][:players]
  all_players = home_players.concat(away_players)
  return all_players
end

def player_stats(player)
  combine_players(game_hash).each do |hash|
    if hash[:player_name] == player 
      return stats_hash(hash)
  # binding.pry
    end
  end
end

def big_shoe_rebounds
  biggest = combine_players(game_hash).reduce do |memo, hash|
    memo[:shoe] > hash[:shoe] ? memo : hash
  end
  return biggest[:rebounds]
end

def most_points_scored
  points = combine_players(game_hash).reduce do |memo, hash|
    memo[:points] > hash[:points] ? memo : hash
  end
  return points[:player_name]
end

def winning_team
  home_players = game_hash[:home][:players]
  away_players = game_hash[:away][:players]
  home_total = home_players.reduce(0) { |memo, hash| memo + hash[:points] }
  away_total = away_players.reduce(0) { |memo, hash| memo + hash[:points] }
  if home_total > away_total
    return game_hash[:home][:team_name]
  elsif away_total > home_total
    return game_hash[:away][:team_name]
  else
    return "it was a tie!"
  end
end

def player_with_longest_name
  long_name = combine_players(game_hash).reduce do |memo, hash|
    memo[:player_name].length > hash[:player_name].length ? memo : hash
  end
  return long_name[:player_name]
end

def long_name_steals_a_ton?
  most_steals = combine_players(game_hash).reduce do |memo, hash|
    memo[:steals] > hash[:steals] ? memo : hash
  end
  return player_with_longest_name == most_steals[:player_name]
end










