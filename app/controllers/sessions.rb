post '/login' do
  user = User.find_by_email(params[:email])

  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    return redirect to('/entries')
  else
    redirect to('/')
  end
end

get '/logout' do
  session.clear
  redirect to('/')
end