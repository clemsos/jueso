# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.email                 "mhartl@example.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end


Factory.define :micropost do |micropost|
  micropost.content       "alalal"
  micropost.user_id       "30"
end

