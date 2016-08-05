class Challenge < ActiveRecord::Base
  after_create :add_states_to_challenges

  belongs_to :category

  has_many :challenge_states, dependent: :destroy

  has_many :solved_challenges, through: :flags

  belongs_to :player, foreign_key: :user_id

  has_many :flags, dependent: :destroy, inverse_of: :challenge

  validates :name, :user_id, :division_id, :point_value, :flags, :category_id, :share_increment, :share_decrement, :elapsed_time,
            :point_increment, :point_elapsed_time, :defense_point_increment, :defense_elapsed_time, presence: true

  enum starting_state: ChallengeState.states

  accepts_nested_attributes_for :flags, allow_destroy: true

  # Handles the ordering of all returned challenge objects.
  default_scope -> { order(:id) } # could add an order parameter to the db too, for now will order based upon id (which is ordered by creation time)

  attr_accessor :submitted_flag

  # This bypasses game open check and only looks at the challenge state
  def challenge_open?(division)
    get_state(division).eql? 'open'
  end

  def open?(division)
    (challenge_open?(division) && category.game.open?)
  end

  def solved?
    (SolvedChallenge.where('challenge_id = :challenge', challenge: self).count > 0)
  end

  # Returns whether or not challenge is available to be opened.
  def available?(division)
    get_state(division).eql? 'closed'
  end

  def force_closed?(division)
    get_state(division).eql? 'force_closed'
  end

  def get_current_solved_challenge(user)
    solved_challenge = SolvedChallenge.where('challenge_id = :challenge and user_id = :user',
                                             challenge: self, user: user)
    solved_challenge.first unless solved_challenge.nil?
  end

  def solved_by_user?(user)
    !get_current_solved_challenge(user).nil?
  end

  def get_video_url_for_flag(user)
    current_challenge = get_current_solved_challenge(user)
    current_challenge.flag.video_url unless current_challenge.nil? || current_challenge.flag.nil?
  end

  def get_api_request_for_flag(user)
    current_challenge = get_current_solved_challenge(user)
    current_challenge.flag.api_request unless current_challenge.nil? || current_challenge.flag.nil?
  end

  def set_state(division, new_state)
    challenge_state = challenge_states.find_by(division: division)
    challenge_state.state = new_state
    challenge_state.save
  end

  # adds the defensive points to the player if they have held it uncaptured for long enough
  def self.update_defensive_points
    Player.all.includes(:challenges).each do |player|
      point_value = 0
      player.challenges.each do |challenge|
        if !challenge.solved?
          created_at = challenge.created_at.to_datetime
          last_updated = created_at #initialize with created_at in case we haven't updated points yet
          if !challenge.defense_updated_at.nil?
            last_updated = challenge.defense_updated_at.to_datetime
          end
          time_passed = ((DateTime.current - last_updated) * 24).to_i # the amount of time passed since either when it was created or last_updated
          if time_passed >= challenge.defense_elapsed_time # if we haven't updated defensive points more recently than the time increment then do it
            time_changes_passed = (time_passed / challenge.defense_elapsed_time).to_i # number of elapsed_times's passed
            if time_changes_passed > 0
              point_value += challenge.defense_point_increment * time_changes_passed
              challenge.defense_updated_at += (time_changes_passed * challenge.defense_elapsed_time.hours)
              challenge.save
            end
          end
        end
      end
      if point_value > 0
        ScoreAdjustment.create!(player: player, point_value: point_value, text: 'for defending flags!')
      end
    end
  end

  private

  # Gets the state using a division context
  def get_state(division)
    challenge_states.find_by(division: division).state
  end

  def add_states_to_challenges
    Division.all.find_each do |d|
      ChallengeState.create!(challenge: self, division: d, state: starting_state)
    end
  end
end
