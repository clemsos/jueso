namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_role
    make_users
    make_microposts
    make_relationships
    make_proposals
  end
end

def make_proposals
  a0.times do |n|
    title = 'My #{n+1} Proposal'
    Proposal.create!(:title => title, :description => Faker::Lorem.sentence(5), :awards => Faker::Lorem.sentence(5), :more=> Faker::Lorem.sentence(5), :money => '5000', :tags => 'tag1,tag2,tag3')
  end
end

def make_role
  adminrole = Role.create!(:name =>"Admin")
  memberrole = Role.create!(:name =>"Member")
  2.times do |n|
    Role.create!(:name => 'myrole')
  end
end

def make_users
  User.create!( :username => 'admin', :email => "admin@jue.so",
                       :password => "admin@jue.so",
                       :password_confirmation => "admin@jue.so")
  99.times do |n|
    email = "example-#{n+1}@jue.so"
    password  = "123456789"
    username = "A User"
    User.create!(:email => email, :username => username,
                 :password => password,
                 :password_confirmation => password)
  end
end


def make_relationships
  users = User.all
  user  = users.first
  following = users[1..50]
  followers = users[3..40]
  following.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end


def make_microposts
  User.all(:limit => 6).each do |user|
    50.times do
      user.microposts.create!(:content => Faker::Lorem.sentence(5))
    end
  end  
end

