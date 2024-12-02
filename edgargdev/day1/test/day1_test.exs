defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  test "generates two lists from file input" do
    file_contents = "46669   36559\n54117   62675\n25659   15179\n18867   82784"
    assert Day1.generate_lists(file_contents) == {["46669", "54117", "25659", "18867"],["36559", "62675", "15179", "82784"]}
  end

  test "converts both lists from strings to ints" do
    lists = {["46669", "54117", "25659", "18867"],["36559", "62675", "15179", "82784"]}
    assert Day1.convert_to_ints(lists) == {[46669, 54117, 25659, 18867], [36559, 62675, 15179, 82784]}
  end

  test "orders lists from smallest to largest" do
    lists = {[46669, 54117, 25659, 18867], [36559, 62675, 15179, 82784]}
    assert Day1.order_lists(lists) == {[18867, 25659, 46669, 54117], [15179, 36559, 62675, 82784]}
  end

  test "finds the sum of the differences between the two lists" do
    lists = {[1,2,3], [2,3,4]}
    assert Day1.find_sum_of_differences(lists) == 3
  end

  test "ensure difference is absolute value" do
    lists = {[1,2,3], [3,2,1]}
    assert Day1.find_sum_of_differences(lists) == 4
  end
end
