require("sinatra")
require("sinatra/contrib/all")
require("pry-byebug")

require_relative("../models/transactions.rb")
require_relative("../models/tags.rb")

# index
get "/tags" do
  @tags = Tag.all()
  erb (:"tags/index")
end

# create
post "/tags" do
  @tag = Tag.new(params)
  @tag.save()
  redirect "/tags"
end

# add
get "/tags/add" do
  erb(:"tags/new")
end

# edit
get "/tags/:id/edit" do
  @tag = Tag.find(params[:id])
  erb(:"tags/edit")
end

# edit
post "/tags/:id" do
  @tag = Tag.new(params)
  @tag.update()
  redirect "/tags"
end

# delete
post "/tags/:id/delete" do
  @tag = Tag.new(params)
  @tag.delete()
  redirect "/tags"
end

#show
get "/tags/:id" do
  @tag = Tag.find(params[:id])
  erb(:"tags/show")
end

#show transactions by tag
get "/tags/:id/transactions" do
  @transactions = Transaction.find_by_tag(params[:id])
  erb(:"tags/show_transactions")
end

# binding.pry
# nil
