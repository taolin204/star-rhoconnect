#!/usr/bin/env ruby
require 'rhoconnect/application/init'

# secret is generated along with the app
Rhoconnect::Server.set     :secret,      '4b08ab08b4fbe446d8df59ab55aa65977ac66821c3a25da4da9fa66502ad4cca657f240aebb2b6f8e496039da6fd4daad7ceaa5a47eff592edfb5436b2fb9dc0'

# !!! Add your custom initializers and overrides here !!!
# For example, uncomment the following line to enable Stats
#Rhoconnect::Server.enable  :stats
# uncomment the following line to disable Resque Front-end console
#Rhoconnect.disable_resque_console = true
# uncomment the following line to disable Rhoconnect Front-end console
#Rhoconnect.disable_rc_console = true

# Load RhoConnect application
require './application'

# run RhoConnect Application
run Rhoconnect.app