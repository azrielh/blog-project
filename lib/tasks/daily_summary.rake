namespace :daily_summary do
# passing the parameter as a hash with the value being :environment
# makes it so that the rake task have the Rails environment
# loaded so you can access all the models for instance.s
desc "Make a summary list of all newly created comments for the each posts for that day"
task :generate_summary_list => :environment do
  date = DateTime.now - 1.days

  users = User.all

  users.each do |u|
    u.posts.each do |p|
      comments = p.comments.where("created_at > ?", 1.days.ago)
      comments.each do |c|
        puts c.body
      end

    end
  end


end


#   question_count = ENV["question_count"] ? ENV["question_count"].to_i : 10
#   answer_count   = ENV["answer_count"] ?   ENV["answer_count"].to_i   : 5
#
#   users          = User.all
#
#   question_count.times do
#     user = users.sample
#     q = user.questions.create(title: Faker::Company.catch_phrase,
#                               body:  Faker::Lorem.paragraph)
#     answer_count.times do
#       a = q.answers.new(body: Faker::Company.bs)
#       a.user = users.sample
#       a.save
#     end
#   end




end
