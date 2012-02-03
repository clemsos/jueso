# Crowdfunding platform #

This is the README file for a crowdfunding platform created first for jue.so website (Shanghai, 2011).

View test website http://deep-sword-8508.herokuapp.com/


## Functionalities ##

#### Crowdfunding platform ####
  * Crowfunding solution : rewarding, funding, deadline+expiration
  * Follow project life through updates and comments 
  * Project moderation : submission require admin approval
  * All registered users can submit projects

#### For creative people ####
  * Customize profile (avatar, geo-loc, etc)
  * Advanced users can open a personal portfolio
  * Profile can be turn into personal website

#### Community-oriented ####
  * can follow projects + users
  * can post updates through profile 
  * can update profile through social networks (to be implemented)

#### Others ####
  * Editorial : projects can be featured on home
  * Multilingual : Includes English and Chinese
  * Beta test : build for beta test and production

## Admin ##
You can access admin control panel through 

	yourwebsite.com/admin

The ADMIN users are NOT related with users regitered through front-end website.

They are stored in separate tables and models (AdminUser).

Admins can be created through console only :
    
    clemsos@ubuntu:~/Sites/jueso$ rails c
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

## Upload a project : ##
1. Register
2. Confirm account
2. Upload a project proposal (Proposal)
4. Proposals are reviewed by Admin (pending, rejected, accepted)
5. If proposal is accepted, then it becomes a project (Project)
    
    * published
    * unpublished
    * funded 
    * expired (time out)
    * deleted (by Admin or User)
    
 
## Enable beta test mode ##

When Beta mode is enable, you will have to add users to Beta list before they can register (BetaInvite).

To enable/disable beta invitations, uncomment/comment line 11 in app/model/User.rb

    
   before_validation :beta_invited?
    


## Requirements ##
Written with :
  * Rails 3
  * Ruby 1.9.3
  * Mysql 5
  * ImageMagik

Available under MIT License, Clément Renaud @clemsos, 2011
