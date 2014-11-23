get '/users/new' do
  @user = User.new
  erb :"user/new"
end

post '/users/new' do
  password_confirmation = params[:password_conf]
  params.delete('password_conf')

  @user = User.new(params)

  if password_confirmation != params[:password]
    @error = 'Password and password confirmation must match'
    return erb :"user/new"
  end

  if !@user.save
    @error = @user.first_error
    return erb :"user/new"
  end

  redirect to('/')
end

get '/users/:id/entries' do
  @author = User.find_by_id(params[:id])
  @entries = @author.entries.order('created_at DESC')
  erb :"user/show"
end

get '/users' do
  @writers = User.all.order('updated_at DESC')
  erb :"user/index"
end
