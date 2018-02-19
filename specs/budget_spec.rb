require("minitest/autorun")
require("minitest/rg")

require_relative("../models/budget.rb")

class TestBudget < Minitest::Test

  def setup()
    @date1 = Budget.todays_date()
    @date2 = Budget.next_pay_date(1,[2018,02,19])
    @date3 = Budget.next_pay_date(15,[2018,02,19])
    @date4 = Budget.next_pay_date(28,[2018,02,19])
    @date5 = Budget.next_pay_date(15,[2017,12,19])
    @date6 = Budget.prev_pay_date(1,[2018,02,19])
    @date7 = Budget.prev_pay_date(15,[2018,02,19])
    @date8 = Budget.prev_pay_date(28,[2018,02,19])
    @date9 = Budget.prev_pay_date(28,[2018,01,19])
  end

  def test_returns_todays_date()
    assert_equal([2018,02,19], @date1)
  end

  def test_returns_next_pay_date()
    assert_equal([2018,03,01], @date2)
    assert_equal([2018,03,15], @date3)
    assert_equal([2018,02,28], @date4)
    assert_equal([2018,01,15], @date5)
  end

  def test_returns_previous_pay_date()
    assert_equal([2018,02,01], @date6)
    assert_equal([2018,02,15], @date7)
    assert_equal([2018,01,28], @date8)
    assert_equal([2017,12,28], @date9)
  end


end
