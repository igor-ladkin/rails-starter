# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "🛠 Preparing DB to be seeded"
puts "💣 Destroying all records"
ApplicationRecord.connection.truncate_tables(
  Content::Reaction.table_name,
  Content::Comment.table_name,
  Content::Post.table_name,
  Accounts::User.table_name
)

puts "🤖 Creating users"
user_names = %w[
  marko
  samantha
  remi
  björn
  igor
  sasho
  alex
  ves
  aileene
  dimitar
  drew
  max
  nathan
  dominique
  vishal
  alexis
  jessica
  maxime
  akshay
  alan
  james
  dave
]

users = Accounts::User.create! user_names.map { {name: _1} }
user_ids = users.map(&:id)

fake_user_count = ENV.fetch("FAKE_USER_COUNT", 100).to_i
puts "🥷 Creating fake #{fake_user_count} users"
fake_user_count.times.flat_map do
  {name: "fake-user-#{_1}"}
end.then { Accounts::User.insert_all! _1 }
fake_user_ids = Accounts::User.where.not(id: user_ids).ids

post_count = ENV.fetch("POST_COUNT", 100).to_i
puts "📝 Creating #{post_count} posts"
post_count.times.flat_map do
  {author_id: user_ids.sample, title: Faker::Hipster.sentence, text: Faker::Hipster.paragraph}
end.then { Content::Post.insert_all! _1 }

fake_user_activity = ENV.fetch("FAKE_USER_ACTIVITY", 0.5).to_f.clamp(0, 1)
puts "🎭 Creating comments and reactions with fake user activity #{fake_user_activity.inspect}"
pick_non_authors = ->(post) { user_ids.without(post.author_id).sample(5) }
pick_fake_users = ->(range = ((1 - fake_user_activity) * fake_user_count)..fake_user_count) { fake_user_ids.sample(rand(range)) }

Content::Post.find_in_batches do |posts|
  posts.flat_map do |post|
    pick_non_authors[post].map do |user_id|
      {post_id: post.id, author_id: user_id, text: Faker::Hipster.sentence(word_count: rand(2..5))}
    end
  end.then { Content::Comment.insert_all! _1 }

  posts.flat_map do |post|
    pick_non_authors[post].concat(pick_fake_users[]).map do |user_id|
      {post_id: post.id, user_id: user_id, kind: Content::Reaction.kinds.keys.sample}
    end
  end.then { Content::Reaction.insert_all! _1 }
end

puts "🔧 Generated #{Content::Comment.count} comments"
puts "🪚 Generated #{Content::Reaction.count} reactions"

puts "🎉 Done seeding"
