require("minitest/autorun")
require("minitest/rg")

require_relative("../models/budget.rb")

class TestBudget < Minitest::Test

  def setup()
    @date1 = Budget.todays_date()
    @date2 = Budget.next_pay_date(1,[2018,02,19])
    @date3 = Budget.next_pay_date(15,[2018,02,19])
    @date4 = Budget.next_pay_date(28,[2018,02,19])
  end

  def test_returns_todays_date()
    assert_equal([2018,02,19], @date1)
  end

  def test_returns_next_pay_date()
    assert_equal([2018,03,01], @date2)
    assert_equal([2018,03,15], @date3)
    assert_equal([2018,02,28], @date4)
  end

end
