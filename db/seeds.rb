# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# default admin user - CHANGE PASSWORD!!!
Admin.create!(email: 'root', password: 'ChangePa$$w0rd')

# default game
game = Game.create!(name: 'Test Game', start: Time.now, stop: Time.now + 2.days,
  tos: "<p><strong>Rules</strong></p>\r\n<ul>\r\n<li>Absolutely no flag sharing! (Why help your competitors?)</li>\r\n
<li>You may not do anything to diminish the competition experience for other players on the system; 
if you are worried that you might break something, ask an operator in IRC (with a private message) for clarification. 
We love creativity, just clear it with us first.</li>\r\n
<li>Foul play will not be tolerated (first offense is a warning, second offense is an appropriate point deduction and 
third offense is a disqualification).</li>\r\n<li>No bullying. This includes harassment, intimidation and threats.</li>\r\n
<li>Operator decisions are final.</li>\r\n</ul>\r\n<p><strong>Etiquette</strong></p>\r\n<ul>\r\n
<li>Keep it clean in IRC and MPAA G-rated conversations, please.</li>\r\n
<li>Remember that operators in IRC channel are running the game.</li>\r\n
<li>Be a good sport throughout the competition.</li>\r\n</ul>\r\n<p><strong>Flag Format</strong></p>\r\n<ul>\r\n
<li>All flags are either of the form MCA-[8 hex digits] such as MCA-ABCDEF12 or an SHA1 hash.</li>\r\n
<li>Case does not matter when submitting to the scoreboard, it will downcase your submission automatically.</li>\r\n</ul>\r\n\r\n
<p><strong>Challenge Colors</strong></p>\r\nChallenges will sometimes show up as different colors, the possible colors and 
their meanings are as follows:\r\n<ul>\r\n<li><b style=\"color:green;\">Green:</b> Available and ready to be solved by your team.</li>\r\n
<li><b style=\"color:#08C;\">Blue:</b> Available and already solved by your team.</li>\r\n
<li><b style=\"color:DarkOrange;\">Orange:</b> Solved by a team but locked by admins due to issue with the challenge.<br /></li>\r\n
<li><b style=\"color:red;\">Red:</b> Unsolved by any team and locked by admins.</li>\r\n
<li><b style=\"color:gray;\">Gray:</b> Will open when preceding challenge is solved.</li>\r\n</ul>"
)


division1 = Division.create!(name: "High School", game_id: game.id)

# players
player1 = Player.create!(display_name: 'TeamA', email: 'TeamA', password: 'test123456', division_id: division1.id)
player2 = Player.create!(display_name: 'TeamB', email: 'TeamB', password: 'test123456', division_id: division1.id)
player3 = Player.create!(display_name: 'TeamC', email: 'TeamC', password: 'test123456', division_id: division1.id)
player4 = Player.create!(display_name: 'TeamD', email: 'TeamD', password: 'test123456', division_id: division1.id)

# crypto
category = Category.create!(name: 'Crypto', game: game)
Challenge.create!(name: 'Challenge A-1', point_value: 100, share_increment: 50, share_decrement: 1,
                  elapsed_time: 1, point_increment: 100, point_elapsed_time: 12, defense_point_increment: 50,
                  defense_elapsed_time: 12, flags: [ Flag.create(flag: "flag") ],
                  starting_state: 'open', division_id: division1.id, user_id: player1.id,  category: category)
Challenge.create!(name: 'Challenge A-2', point_value: 100, share_increment: 50, share_decrement: 1,
                  elapsed_time: 1, point_increment: 100, point_elapsed_time: 12, defense_point_increment: 50,
                  defense_elapsed_time: 12, flags: [ Flag.create(flag: "flag") ],
                  starting_state: 'open', division_id: division1.id, user_id: player1.id, category: category)
Challenge.create!(name: 'Challenge A-3', point_value: 100, share_increment: 50, share_decrement: 1,
                  elapsed_time: 1, point_increment: 100, point_elapsed_time: 12, defense_point_increment: 50,
                  defense_elapsed_time: 12, flags: [ Flag.create(flag: "flag") ],
                  starting_state: 'open', division_id: division1.id, user_id: player1.id, category: category)
Challenge.create!(name: 'Challenge A-4', point_value: 100, share_increment: 50, share_decrement: 1,
                  elapsed_time: 1, point_increment: 100, point_elapsed_time: 12, defense_point_increment: 50,
                  defense_elapsed_time: 12, flags: [ Flag.create(flag: "flag") ],
                  starting_state: 'open', division_id: division1.id, user_id: player1.id, category: category)
Challenge.create!(name: 'Challenge A-5', point_value: 100, share_increment: 50, share_decrement: 1,
                  elapsed_time: 1, point_increment: 100, point_elapsed_time: 12, defense_point_increment: 50,
                  defense_elapsed_time: 12, flags: [ Flag.create(flag: "flag") ],
                  starting_state: 'open', division_id: division1.id, user_id: player1.id, category: category)

Challenge.create!(name: 'Challenge B-1', point_value: 100, share_increment: 50, share_decrement: 1,
                  elapsed_time: 1, point_increment: 100, point_elapsed_time: 12, defense_point_increment: 50,
                  defense_elapsed_time: 12, flags: [ Flag.create(flag: "flag") ],
                  starting_state: 'open', division_id: division1.id, user_id: player2.id,  category: category)
Challenge.create!(name: 'Challenge B-2', point_value: 100, share_increment: 50, share_decrement: 1,
                  elapsed_time: 1, point_increment: 100, point_elapsed_time: 12, defense_point_increment: 50,
                  defense_elapsed_time: 12, flags: [ Flag.create(flag: "flag") ],
                  starting_state: 'open', division_id: division1.id, user_id: player2.id, category: category)
Challenge.create!(name: 'Challenge B-3', point_value: 100, share_increment: 50, share_decrement: 1,
                  elapsed_time: 1, point_increment: 100, point_elapsed_time: 12, defense_point_increment: 50,
                  defense_elapsed_time: 12, flags: [ Flag.create(flag: "flag") ],
                  starting_state: 'open', division_id: division1.id, user_id: player2.id, category: category)
Challenge.create!(name: 'Challenge B-4', point_value: 100, share_increment: 50, share_decrement: 1,
                  elapsed_time: 1, point_increment: 100, point_elapsed_time: 12, defense_point_increment: 50,
                  defense_elapsed_time: 12, flags: [ Flag.create(flag: "flag") ],
                  starting_state: 'open', division_id: division1.id, user_id: player2.id, category: category)
Challenge.create!(name: 'Challenge B-5', point_value: 100, share_increment: 50, share_decrement: 1,
                  elapsed_time: 1, point_increment: 100, point_elapsed_time: 12, defense_point_increment: 50,
                  defense_elapsed_time: 12, flags: [ Flag.create(flag: "flag") ],
                  starting_state: 'open', division_id: division1.id, user_id: player2.id, category: category)

Challenge.create!(name: 'Challenge C-1', point_value: 100, share_increment: 50, share_decrement: 1,
                  elapsed_time: 1, point_increment: 100, point_elapsed_time: 12, defense_point_increment: 50,
                  defense_elapsed_time: 12, flags: [ Flag.create(flag: "flag") ],
                  starting_state: 'open', division_id: division1.id, user_id: player3.id,  category: category)
Challenge.create!(name: 'Challenge C-2', point_value: 100, share_increment: 50, share_decrement: 1,
                  elapsed_time: 1, point_increment: 100, point_elapsed_time: 12, defense_point_increment: 50,
                  defense_elapsed_time: 12, flags: [ Flag.create(flag: "flag") ],
                  starting_state: 'open', division_id: division1.id, user_id: player3.id, category: category)
Challenge.create!(name: 'Challenge C-3', point_value: 100, share_increment: 50, share_decrement: 1,
                  elapsed_time: 1, point_increment: 100, point_elapsed_time: 12, defense_point_increment: 50,
                  defense_elapsed_time: 12, flags: [ Flag.create(flag: "flag") ],
                  starting_state: 'open', division_id: division1.id, user_id: player3.id, category: category)
Challenge.create!(name: 'Challenge C-4', point_value: 100, share_increment: 50, share_decrement: 1,
                  elapsed_time: 1, point_increment: 100, point_elapsed_time: 12, defense_point_increment: 50,
                  defense_elapsed_time: 12, flags: [ Flag.create(flag: "flag") ],
                  starting_state: 'open', division_id: division1.id, user_id: player3.id, category: category)
Challenge.create!(name: 'Challenge C-5', point_value: 100, share_increment: 50, share_decrement: 1,
                  elapsed_time: 1, point_increment: 100, point_elapsed_time: 12, defense_point_increment: 50,
                  defense_elapsed_time: 12, flags: [ Flag.create(flag: "flag") ],
                  starting_state: 'open', division_id: division1.id, user_id: player3.id, category: category)

Challenge.create!(name: 'Challenge D-1', point_value: 100, share_increment: 50, share_decrement: 1,
                  elapsed_time: 1, point_increment: 100, point_elapsed_time: 12, defense_point_increment: 50,
                  defense_elapsed_time: 12, flags: [ Flag.create(flag: "flag") ],
                  starting_state: 'open', division_id: division1.id, user_id: player4.id,  category: category)
Challenge.create!(name: 'Challenge D-2', point_value: 100, share_increment: 50, share_decrement: 1,
                  elapsed_time: 1, point_increment: 100, point_elapsed_time: 12, defense_point_increment: 50,
                  defense_elapsed_time: 12, flags: [ Flag.create(flag: "flag") ],
                  starting_state: 'open', division_id: division1.id, user_id: player4.id, category: category)
Challenge.create!(name: 'Challenge D-3', point_value: 100, share_increment: 50, share_decrement: 1,
                  elapsed_time: 1, point_increment: 100, point_elapsed_time: 12, defense_point_increment: 50,
                  defense_elapsed_time: 12, flags: [ Flag.create(flag: "flag") ],
                  starting_state: 'open', division_id: division1.id, user_id: player4.id, category: category)
Challenge.create!(name: 'Challenge D-4', point_value: 100, share_increment: 50, share_decrement: 1,
                  elapsed_time: 1, point_increment: 100, point_elapsed_time: 12, defense_point_increment: 50,
                  defense_elapsed_time: 12, flags: [ Flag.create(flag: "flag") ],
                  starting_state: 'open', division_id: division1.id, user_id: player4.id, category: category)
Challenge.create!(name: 'Challenge D-5', point_value: 100, share_increment: 50, share_decrement: 1,
                  elapsed_time: 1, point_increment: 100, point_elapsed_time: 12, defense_point_increment: 50,
                  defense_elapsed_time: 12, flags: [ Flag.create(flag: "flag") ],
                  starting_state: 'open', division_id: division1.id, user_id: player4.id, category: category)
