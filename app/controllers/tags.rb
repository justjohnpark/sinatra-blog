get '/tags' do
  @tags = Tag.all.order('created_at DESC')
  erb :"tag/index"
end

get '/tags/:id' do
  @tag = Tag.find_by(id: params[:id])
  erb :"tag/show"
end
