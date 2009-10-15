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
		
		@users = User.find(:all, :order=>"id")
	end
	
	def user_edit
    puts '--------------------------------'
    puts 'user_edit!'
    puts '--------------------------------'
		
		@user = User.find(params[:id])
	end
	
	def user_save
    puts '--------------------------------'
    puts 'user_save!'
    puts '--------------------------------'
		
		p params[:user]
		@user = User.find(params[:id])
		@user.update_attributes(params[:user])
		
		redirect_to url_for(:controller=>:admin, :action=>:user_index)
	end
	
	def user_delete
    puts '--------------------------------'
    puts 'user_delete!'
    puts '--------------------------------'
		
		@user = User.find(params[:id])
		@user.destroy
		
		redirect_to url_for(:controller=>:admin, :action=>:user_index)
	end
end
