# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
  User.transaction do
    1..40.times do |i|
      user = User.create!(surname: "Surname",
                       firstname:  "Firstname",
                       email:      "cwl#{i}@aber.ac.uk",
                       phone:      '01970622422',
                       jobs:       true,
                       grad_year:  1985)
      UserDetail.create!(login:  "cwl#{i}",
                       password: 'secret',
                       user:     user)
  end

  users = YAML::load_file(File.dirname(__FILE__) + "/../test/fixtures/users.yml")

  users.each do |user_config|
    user_config = user_config[1]
    $user = User.create!(surname:  user_config['surname'],
                        firstname: user_config['firstname'],
                        email:     user_config['email'],
                        phone:     user_config['phone'],
                        grad_year: user_config['grad_year'])

    #username = user_config['email'][/[^@]+/]
    
    UserDetail.create!(login:    'admin',
                       password: 'taliesin',
                       user:     $user)
  end

  # Create some dummy feeds
  feed_twitter  = Feed.create!(name: 'twitter')
  feed_facebook = Feed.create!(name: 'facebook')
  feed_email    = Feed.create!(name: 'email')
  feed_rss      = Feed.create!(name: 'RSS')
  feed_atom     = Feed.create!(name: 'atom')

  user = $user # set $user to the last user of the yaml file
  # id 1
  Broadcast.create!(user_id: user,
                    content: "Hello, World!",
                    feeds: [feed_twitter, feed_email])
  # id 2
  Broadcast.create!(user_id: user,
                    content: "Hello, World... again!",
                    feeds: [feed_twitter, feed_email])
  # id 3
  Broadcast.create!(user_id: user,
                    content: "I'm going to be deleted!",
                    feeds: [feed_twitter])
  # id 4
  Broadcast.create!(user_id: user,
                    content: "Hello, World... yet again.",
                    feeds: [feed_email])
  # id 5
  Broadcast.create!(user_id: user,
                    content: "Hello, World... again and again and again!",
                    feeds: [feed_facebook])
  # and thereafter
  1..5.times do 
    Broadcast.create!(user_id: user,
                      content: "copy_and_paste_me",
                      feeds: [feed_email])
  end
end