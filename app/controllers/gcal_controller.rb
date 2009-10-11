class GcalController < ApplicationController
  include GoogleCal
  include DataExport
  
  
  def index
    puts '--------------------------------'
    puts 'Index!'
    puts '--------------------------------'
    
    
  end

	def auth_gcal
    puts '--------------------------------'
    puts 'auth_gcal!'
    puts '--------------------------------'
    
    auth_googlecal(params[:yyyymmdd])
	end

  def get_schedule
    puts '--------------------------------'
    puts 'schedule!'
    puts '--------------------------------'
    
    @lists = get_googlecal_schedule(params[:yyyymmdd])
  end

  def export
    puts '--------------------------------'
    puts 'export!'
    puts '--------------------------------'
    
    data = params[:data]
    csv_text = make_csv_text(data)
    
    send_data(csv_text, :type=>'text/csv', :filename=>"export.csv")
  end
	
end
