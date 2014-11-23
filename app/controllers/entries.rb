get '/entries' do
  @entries = Entry.all.order('created_at DESC')
  erb :"entry/index"
end

get '/entries/new' do

  if !logged_in?
    return redirect to('/entries')
  end

  @entry = Entry.new
  erb :"entry/new"
end

get '/entries/:id' do
  @entry = Entry.find_by(id: params[:id])
  @author = User.find_by_id(session[:user_id])

  if @entry == nil
    redirect to '/entries'
  end

  erb :"entry/show"
end

get '/entries/:id/edit' do
  @entry = Entry.find_by(id: params[:id])
  @author = User.find_by_id(session[:user_id])

  if @entry == nil
    redirect to '/entries'
  end  

  if !logged_in? || @entry.user != @author
    return redirect to("/entries/#{params[:id]}")
  end

  if @entry == nil
    redirect to '/entries'
  end

  @tags = Tag.tags_to_string(@entry.tags)
  erb :"entry/edit"
end

delete '/entries/:id' do
  entry = Entry.find_by(id: params[:id])
  entry.destroy

  redirect to("/entries")
end

put '/entries/:id' do
  entry = Entry.find_by(id: params[:id])
  entry.title = params[:entry][:title]
  entry.content = params[:entry][:content]
  entry.tags = Tag.string_to_tags(params[:entry][:tags])

  if entry.save
    redirect to("/entries/#{entry.id}")
  else
    @entry = entry
    @tags = Tag.tags_to_string(@entry.tags)
    @error = @entry.first_error
    erb :"entry/edit"
  end
end

post '/entries' do
  entry = Entry.new
  entry.title = params[:entry][:title]
  entry.content = params[:entry][:content]
  entry.tags = Tag.string_to_tags(params[:entry][:tags])

  if entry.save
    user = User.find_by_id(session[:user_id])
    user.entries << entry
    redirect to("/entries/#{entry.id}")
  else
    @entry = entry
    @error = @entry.first_error
    erb :"entry/new"
  end
end
