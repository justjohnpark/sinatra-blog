get '/' do
  if logged_in?
    return redirect to('/entries')
  end
  erb :index
end
