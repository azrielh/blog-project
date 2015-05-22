namespace :fake_data do

  desc "Database populator"
  task populate: :environment do
    User.create(first_name: "admin", last_name: "admin", email: "account@admin.com", password: "12345678", password_confirmation: "12345678", is_admin: true )

    4.times { |x| Post.create(title: "Blog #{x + 1} " + Faker::Company.catch_phrase, body: Faker::Hacker.say_something_smart, user_id: 1) }

    20.times {Comment.create(body: Faker::Lorem.paragraph, user_id: ((User.all.map).each { |x| x.id}).sample, post_id: ((Post.all.map).each { |x| x.id}).sample)}

  end

end
