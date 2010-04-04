# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

User.create(:email => "maya.natsume@juken-club.jp", :username => "natsume", :first_name => "Maya", :last_name => "Natsume")
User.create(:email => "sanji@strawhat-pirates.jp", :username => "sanji", :first_name => "Sanji", :last_name => "The Cook")
User.create(:email => "zorro@strawhat-pirates.jp", :username => "zoro", :first_name => "Zoro", :last_name => "Lorenor")
User.create(:email => "seras.victoria@hellsing.co.uk", :username => "seras", :first_name => "Seras", :last_name => "Victoria")