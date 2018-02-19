require("sinatra")
require("sinatra/contrib/all")
require("pry-byebug")

require_relative("../models/budget.rb")
require_relative("../models/transactions.rb")
require_relative("../models/merchants.rb")
require_relative("../models/users.rb")
require_relative("../models/tags.rb")

# index
get "/tags" do
  @tags = Tag.all()
  erb (:"tags/index")
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
# end

# binding.pry
# nil
