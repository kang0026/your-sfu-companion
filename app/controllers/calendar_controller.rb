class CalendarController < ApplicationController

	layout false
	before_action :require_user
	
  	def index
  	end

	# def redirect
	# 	client = Signet::OAuth2::Client.new({
	# 	client_id: ENV.fetch('24035696255-j51rkv134eq2v80d4hp032k7uvfunueg.apps.googleusercontent.com'),
	# 	client_secret: ENV.fetch('hnyW7rmTk_84ivjU1xP5_XDF'),
	# 	authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
	# 	scope: Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY,
	# 	redirect_uri: url_for(:action => :callback)
	# 	})

	# 	redirect_to 'http://localhost:3000/calendar/index'
	# end

	# def callback
	# 	client = Signet::OAuth2::Client.new({
	# 	client_id: ENV.fetch('24035696255-j51rkv134eq2v80d4hp032k7uvfunueg.apps.googleusercontent.com'),
	# 	client_secret: ENV.fetch('GhnyW7rmTk_84ivjU1xP5_XDF'),
	# 	token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
	# 	redirect_uri: url_for(:action => :callback),
	# 	code: params[:code]
	# 	})

	# 	response = client.fetch_access_token!

	# 	session[:access_token] = response['access_token']

	# 	redirect_to url_for(:action => :calendars)
	# end

	# def calendars
	#   client = Signet::OAuth2::Client.new(access_token: session[:access_token])

	#   service = Google::Apis::CalendarV3::CalendarService.new

	#   service.authorization = client

	#   @calendar_list = service.list_calendar_lists
	# end

	


end
