require("sinatra")
require("sinatra/contrib/all")
require("pry-byebug")

require_relative("../models/budget.rb")
require_relative("../models/users.rb")

# index
get "/budget" do
  @users = User.all()
  erb (:"budget/index")
end

#show
get "/budget/:id" do
  @users = User.find(params[:id])
  @user_transactions = Budget.find_all_transactions_for_user(@users.id)
  @total_recurring_transactions = Budget.total_recurring_transactions_for_user(@users.id)
  @current_date = Budget.todays_date()
  @prev_pay_date = Budget.prev_pay_date(@users.pay_date, @current_date)
  @next_pay_date = Budget.next_pay_date(@users.pay_date, @current_date)
  @total_non_recurring_transactions = Budget.total_non_recurring_transactions_for_user_since(@users.id, @prev_pay_date)
  @budget_after_transactions = Budget.deduct_transactions_from_budget(@users.budget, @total_recurring_transactions, @total_non_recurring_transactions)
  @remaining_daily_budget = Budget.calculate_remaining_budget(@current_date, @next_pay_date, @budget_after_transactions)
  erb(:"budget/show")
end

# binding.pry
# nil
