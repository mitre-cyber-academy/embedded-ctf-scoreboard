module ChallengesHelper
  def embed(youtube_url)
    youtube_id = youtube_url.split('v=').last
    content_tag(:iframe, nil, src: "//www.youtube.com/embed/#{youtube_id}", frameborder: 0)
  end

  # updates the challenge with share amount and point number based on time events
  # also returns the point_value to print in the HTML table
  def update_challenge(challenge)
    if !challenge.solved?
      created_at = challenge.created_at.to_datetime
      current_time = DateTime.current
      last_updated = created_at #initialize with created_at in case we haven't updated points yet
      if !challenge.point_updated_at.nil?
        last_updated = challenge.point_updated_at.to_datetime
      end
      time_passed = ((current_time - last_updated) * 24).to_i # the amount of time passed since either when it was created or last_updated
      if time_passed >= challenge.point_elapsed_time # if we haven't updated points more recently than the time increment then do it
        time_changes_passed = (time_passed / challenge.point_elapsed_time).to_i # number of elapsed_times's passed
        if time_changes_passed > 0
          time_changes_passed.times do
            challenge.point_value += challenge.point_increment
            challenge.point_updated_at = DateTime.current
            challenge.save
          end
        end
      end
    end
    share_ratio = 1
    point_value = challenge.point_value
    total_shares = challenge.shares
    foundSolved = false
    @solvedChallenges.count.times do |j|
      solved = @solvedChallenges[j]
      if solved[:challenge_id] == challenge.id
        solved_at = challenge.solved_at.to_datetime
        last_updated = solved_at #initialize with solved_at in case we haven't set share_updated_at yet
        if !challenge.share_updated_at.nil? # if we have set share_updated_at get the time, else go and do everything and set it
          last_updated = challenge.share_updated_at.to_datetime
        end
        current_time = DateTime.current
        time_passed = ((current_time - last_updated) * 24).to_i #the amount of time passed either when it was solved or last_updated
        if time_passed >= challenge.elapsed_time # if we haven't updated more recently than the time increment then update the shares
          time_changes_passed = (time_passed / challenge.elapsed_time).to_i # number of elapsed_times's passed
          if time_changes_passed > 0
            time_changes_passed.times do
              challenge.share_increment -= challenge.share_decrement
              challenge.share_updated_at = DateTime.current
              challenge.save
            end
          end
        end
        if solved[:user_id] == current_user[:id]
          share_ratio = @solvedChallenges[j][:share_number].to_f / total_shares
          foundSolved = true
        end
      end
    end
    if !foundSolved
      going_rate_of_shares = challenge.share_increment
      #calculate what the ratio would be if they completed it right now if they haven't completed it yet
      share_ratio = going_rate_of_shares.to_f / (total_shares + going_rate_of_shares)
    end
    point_value = challenge.point_value * share_ratio #return point value to print in the table
  end

  # adds the defensive points to the player if they have held it uncaptured for long enough
  def update_defensive_points
    @game.players.each do |player|
      point_value = 0
      challenges = @game.challenges
      challenges.each do |challenge|
        if challenge.user_id == player.id
          if !challenge.solved?
            created_at = challenge.created_at.to_datetime
            current_time = DateTime.current
            last_updated = created_at #initialize with created_at in case we haven't updated points yet
            if !challenge.defense_updated_at.nil?
              last_updated = challenge.defense_updated_at.to_datetime
            end
            time_passed = ((current_time - last_updated) * 24).to_i # the amount of time passed since either when it was created or last_updated
            if time_passed >= challenge.defense_elapsed_time # if we haven't updated defensive points more recently than the time increment then do it
              time_changes_passed = (time_passed / challenge.defense_elapsed_time).to_i # number of elapsed_times's passed
              if time_changes_passed > 0
                time_changes_passed.times do
                  point_value += challenge.defense_point_increment
                  challenge.defense_updated_at = DateTime.current
                  challenge.save
                end
              end
            end
          end
        end
      end
      if point_value > 0
        ScoreAdjustment.create!(player: player, point_value: point_value, text: 'for defending flags!')
      end
    end
  end
end
