RailsAdmin.config do |config|
  config.current_user_method { current_user } # auto-generated

  config.label_methods << :email

  config.authorize_with do
    redirect_to main_app.root_path unless current_user.try(:admin?)
  end

  config.model User do
    visible false
  end

  config.model FeedItem do
    visible false
  end

  config.model Key do
    list do
      fields :player, :name, :updated_at
    end
  end

  config.model Admin do
    edit do
      field :email do
        label 'Login'
      end
      fields :password, :password_confirmation
    end
    list do
      field :id
      field :email do
        label 'Login'
      end
      fields :current_sign_in_at, :locked_at
    end
  end

  config.model Player do
    configure :change_password
    edit do
      field :email do
        label 'Login'
      end
      field :city do
        label 'Location'
      end
      exclude_fields :password, :password_confirmation
      field :display_name
      field :tags
      field :division
      field :city
      field :affiliation
      field :eligible
      field :change_password
      field :change_password do
        label 'Password'
      end
    end
    list do
      field :id
      field :display_name
      field :current_sign_in_at
      field :locked_at
      field :division
    end
    create do
      field :change_password do
        label 'Password'
        required :true
      end
    end
    export do
      configure :score, :integer do
        export_value do
          bindings[:object].score
        end
      end
    end
  end

  config.model Game do
    configure :disable_vpn, :boolean
    configure :disable_flags_an_hour_graph, :boolean
    list do
      fields :name, :start, :stop
    end
    edit do
      fields :name, :start, :stop, :irc
      field :tos do
        label 'Terms of Service'
      end
      field :disable_vpn do
        label 'Hide VPN Cert Download'
      end
      field :disable_flags_an_hour_graph do
        label 'Hide Flags/Hour graph from Game Summary'
      end
    end
  end

  config.model Category do
    list do
      fields :name, :game
    end
    edit do
      fields :name, :game
    end
  end

  config.model Challenge do
    list do
      fields :name, :user_id, :division_id, :point_value, :shares, :starting_state, :category
    end
    edit do
      fields :name, :description
      field :user_id do
        help 'Required - The user who owns the challenge'
      end
      fields  :division_id, :point_value, :shares
      field :share_increment do
        help 'Required - The shares a team will receive upon completion'
      end
      field :share_decrement do
        help 'Required - How many fewer shares the challenge is worth after the elapsed time has passed'
      end
      field :elapsed_time do
        help 'Required - The amount of time (in hours) before time based share actions occur'
      end
      field :point_increment do
        help 'Required - The number of points a challenge will raise by after not being solved after the elapsed time has passed'
      end
      field :point_elapsed_time do
        help 'Required - The amount of time (in hours) before adding more points to the challenge if it is not yet solved'
      end
      field :defense_point_increment do
        help 'Required - The number of points awarded to a team if they keep this challenge defended for a certain amount of time'
      end
      field :defense_elapsed_time do
        help 'Required - The amount of time (in hours) before giving the team defence points for this challenge'
      end
      fields :starting_state, :category, :achievement_name
      field :point_elapsed_time do
        help 'Required - The user who owns this challenge'
      end
    end
  end

  config.model Flag do
    nested do
      fields :flag, :api_request, :video_url
    end
  end

  config.model SolvedChallenge do
    list do
      fields :player, :challenge, :created_at
    end
    edit do
      fields :player, :challenge, :created_at
    end
  end

  config.model ScoreAdjustment do
    list do
      fields :player, :point_value
      field :text do
        label 'Comments'
      end
      field :created_at
    end
    edit do
      fields :player, :point_value
      field :text do
        label 'Comments'
      end
    end
  end

  config.model Achievement do
    list do
      field :text do
        label 'Name'
      end
      fields :player, :created_at
    end
    edit do
      field :text do
        label 'Name'
      end
      fields :player
    end
  end

  config.model Message do
    edit do
      fields :title, :game, :text
    end
    list do
      fields :title, :game, :created_at
    end
  end

  config.model SubmittedFlag do
    list do
      fields :player, :challenge, :text, :created_at
    end
  end
end
