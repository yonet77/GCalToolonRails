require "gcalapi"
require "googlecalendar/auth_sub_util"
require "googlecalendar/service_auth_sub"

# gem からGoogleCalenader 用のモジュールをインストールしておく必要アリ
module GoogleCal

  def auth_googlecal(yyyymmdd)
    puts '--------------------------------'
    puts 'auth_googlecal!'
    puts '--------------------------------'
    
    next_url = url_for(:controller=>:gcal, :action=>:get_schedule, :yyyymmdd=>yyyymmdd)
    request_url = GoogleCalendar::AuthSubUtil.build_request_url(next_url, GoogleCalendar::AuthSubUtil::CALENDAR_SCOPE, false, true)

    redirect_to request_url
  end

  def get_googlecal_schedule(yyyymm = Time.now.localtime.beginning_of_month.strftime("%Y-%m-%d"))
    puts '--------------------------------'
    puts 'get_googlecal_schedule!'
    puts '--------------------------------'

    one_time_token = params[:token]
    session_token = GoogleCalendar::AuthSubUtil.exchange_session_token(one_time_token)

    srv = GoogleCalendar::ServiceAuthSub.new(session_token)
    cal = GoogleCalendar::Calendar.new(srv)

    from = yyyymm.to_time(:local)
    to = from.next_month

    time_from = from.utc.strftime("%Y-%m-%dT%X")
    time_to = to.utc.strftime("%Y-%m-%dT%X")

    # イベントを取得
    events = cal.events(:'start-min'=>time_from, :'start-max'=>time_to, :'max-results'=>300)

    # セッショントークンを破棄
    GoogleCalendar::AuthSubUtil.revoke_session_token(session_token)

    schedules = []
    events.each do |e|
      hash = HashWithIndifferentAccess.new
      hash[:title] = e.title
      hash[:desc] = e.desc
      hash[:where] = e.where
      hash[:st] = e.st
      hash[:en] = e.en
      
      schedules.push hash
    end

    #return events
    return schedules
  end

  
end
