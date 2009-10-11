require "gcalapi"
require "googlecalendar/auth_sub_util"
require "googlecalendar/service_auth_sub"


module GoogleCal

  def auth_googlecal(yyyymmdd)
    puts '--------------------------------'
    puts 'auth_googlecal!'
    puts '--------------------------------'
    
    next_url = url_for(:controller=>:gcal, :action=>:get_schedule, :yyyymmdd=>yyyymmdd)
    #scope_url = GoogleCalendar::AuthSubUtil::CALENDAR_SCOPE
    # ネク知恵用にカレンダースコープを設定
    scope_url = "http://calendar.google.com/a/nexchie.com/feeds/"
    request_url = GoogleCalendar::AuthSubUtil.build_request_url(next_url, scope_url, false, true)

    redirect_to request_url
  end

	def create_gcal_session()
    puts '--------------------------------'
    puts 'create_session!'
    puts '--------------------------------'
    one_time_token = params[:token]
    session_token = GoogleCalendar::AuthSubUtil.exchange_session_token(one_time_token)
    
    session[:token] = session_token
	end
	
	def destroy_gcal_session()
    puts '--------------------------------'
    puts 'destroy_session!'
    puts '--------------------------------'
    return "" if session[:token].blank?
    
    # セッショントークンを破棄
    GoogleCalendar::AuthSubUtil.revoke_session_token(session[:token])
	end

  def get_googlecal_schedule(yyyymm = Time.now.localtime.beginning_of_month.strftime("%Y-%m-%d"))
    puts '--------------------------------'
    puts 'get_googlecal_schedule!'
    puts '--------------------------------'
    return "" if session[:token].blank?
    
    srv = GoogleCalendar::ServiceAuthSub.new(session[:token])
    cal = GoogleCalendar::Calendar.new(srv)

    from = yyyymm.to_time(:local)
    to = from.next_month

    time_from = from.utc.strftime("%Y-%m-%dT%X")
    time_to = to.utc.strftime("%Y-%m-%dT%X")

    # イベントを取得
    events = cal.events(:'start-min'=>time_from, :'start-max'=>time_to, :'max-results'=>300)

    schedules = []
    events.each do |e|
      hash = HashWithIndifferentAccess.new
      if e.title =~ /\//
      	hash[:code] = e.title.split(/\//,2)[0]
      	hash[:title] = e.title.split(/\//,2)[1]
      else
      	hash[:code] = ""
      	hash[:title] = e.title
      end
      hash[:desc] = e.desc
      hash[:where] = e.where
      
      hash[:st_date] = e.st.localtime.strftime("%Y/%m/%d %H:%M").split(/ /,2)[0]
      hash[:st_time] = e.st.localtime.strftime("%Y/%m/%d %H:%M").split(/ /,2)[1]
      hash[:st] = e.st
      
      hash[:en_date] = e.en.localtime.strftime("%Y/%m/%d %H:%M").split(/ /,2)[0]
      hash[:en_time] = e.en.localtime.strftime("%Y/%m/%d %H:%M").split(/ /,2)[1]
      hash[:en] = e.en
      
      hash[:time] = (e.en-e.st) / (60*60)
      
      schedules.push hash
    end

    #return events
    return schedules
  end

  
end
