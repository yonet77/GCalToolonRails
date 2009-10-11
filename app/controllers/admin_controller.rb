class AdminController < ApplicationController

	def index
    puts '--------------------------------'
    puts 'index!'
    puts '--------------------------------'
    
    
	end
	
	def user_index
    puts '--------------------------------'
    puts 'user_index!'
    puts '--------------------------------'
		
		@Users = User.find(:all)
		
	end
end
