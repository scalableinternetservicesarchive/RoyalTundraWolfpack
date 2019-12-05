posts = []
childcomments = []
parentcomments= []
users = []
books = []

USERS = 100
BOOKS = 50

i = 0

while i < USERS
  # u = [i.to_s + "@seed.com", "seed" + i.to_s, "asdasd"]
  # puts u
  # users << [i.to_s + "@seed.com", "seed" + i.to_s, "asdasd"]
  user = User.new(email: i.to_s + "@seed.com", username: "seed" + i.to_s, password: "asdasd", password_confirmation: "asdasd") 
  users << user
  i += 1
end

User.import users, validate: false
puts "Seeded Users"

i = 0
columns = [ :title, :author ]
while i < BOOKS
  books << ["seedbook" + i.to_s, "author" + i.to_s] 
  i += 1
end

Book.import columns, books, validate: false
puts "Seeded Books"


columns = [:title, :author, :content, :book_id]
(1..USERS).each do |user_id|
  (1..BOOKS).each do |book_id|
    k = 0
    while k < 1
      posts << ["post_title" + j.to_s, user_id, "content", book_id]
      k += 1
    end
  end
end

Post.import columns, posts, validate: false
puts "Seeded Posts"

MAX_USER_POST = 10
MAX_POSTS = USERS*BOOKS;
columns = [:body, :commentable_id, :commentable_type, :user_id]
(1..MAX_USER_POST).each do |user_id|
  (1..MAX_POSTS).each do |post_id|
    k = 0
    while k < 1
      parentcomments << ["comment_body", post_id, "Post", user_id]
      k += 1
    end
  end
end
Comment.import columns, parentcomments, validate: false
puts "Seeded Parent Comments"


MAX_USERS_P_COMMENT = 2 
MAX_P_COMMENTS = MAX_USER_POST*MAX_POSTS
columns = [:body, :commentable_id, :commentable_type, :user_id]
(1..MAX_USERS_P_COMMENT).each do |user_id|
  (1..MAX_P_COMMENTS).each do |parent_comment_id|
    k = 0
    while k < 2
      childcomments << ["comment_body", parent_comment_id, "Comment", user_id]
      k += 1
    end
  end
end

Comment.import columns, childcomments, validate: false
# puts "Seeded Child Comments"

# users.each do |sender|
#   users.each do |receiver|
#     if sender != receiver
#       ongoing_conversation = Mailboxer::Conversation.between(receiver, sender).find{|c| c.participants.count == 2 }
#       if !ongoing_conversation.present?
#         receipt = sender.send_message(receiver, "seed-message", "default-subject")
#       end
#     end
#   end
# end

# puts "Seeded Start Msgs"

# users.each do |sender|
#   count = 10
#   users.reverse_each do |receiver|
#     if count < 0
#       break
#     end
#     if sender != receiver
#       ongoing_conversation = Mailboxer::Conversation.between(receiver, sender).find{|c| c.participants.count == 2 }
#       if ongoing_conversation.present?
#         i = 0
#         while i < 10
#           receipt = sender.reply_to_conversation(ongoing_conversation, "seed-reply")
#           i += 1
#         end
#       end
#       count -= 1
#     end
#   end
# end

# puts "Seeded Reply Msgs"