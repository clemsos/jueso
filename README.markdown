# Crowdfunding platform #

This is the README file for a crowdfunding platform created first for jue.so website (Shanghai, 2011).


## Admin ##
You can access admin control panel through 

	yourwebsite.com/admin

The ADMIN users are NOT related with users regitered through front-end website.

They are stored in separate tables and models (AdminUser).

Admins can be created through console only :
    
    clement@ubuntu:~/Sites/jueso$ rails c
    Loading development environment (Rails 3.0.9)
    1.9.3p0 :001 > a = AdminUser.new
    1.9.3p0 :002 > a.email = "email@website.com" 
    1.9.3p0 :003 > a.password = "password"
    1.9.3p0 :004 > a.save!
     => true 
    

## About Users ##
For front-end users, there is 4 different users types (Role) :
  * Admin : can do everything
  * Member : can edit his profile, start a Proposal
  * Artist : advanced profile (portfolio
  * Institution 

You can add roles through admin interface.
Permissions management : check app/models/ability.rb

### Upload a project : ###

1. Register
2. Confirm account
2. Upload a project proposal (Proposal)
4. Proposals are reviewed by Admin
    * pending
    * rejected
    * accepted 
5. If proposal is accepted, then it becomes a project (Project)
    * published
    * unpublished
    * funded 
    * expired (time out)
    * deleted (by Admin or User)


#### Community oriented ####
  * own profile
  * can follow projects + users
  * can post updates through his profile 


## Requirements ##
Written with :
  * Rails 3
  * Ruby 1.9.3
  * ImageMagik


@clemsos, 2011
