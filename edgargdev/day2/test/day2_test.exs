defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  test "parse lines from file into int lists" do
    assert Day2.parse_lines_from_files("test/test.txt") == [[7,6,4,2,1], [1,2,7,8,9], [9,7,6,2,1], [1,3,2,4,5], [8,6,4,4,1], [1,3,6,7,9]]
  end

  test "int list with only increasing numbers is safe" do
    assert Day2.find_safe_level([1,2,3,4,5]) == 1
  end

  test "int list with only decreasing numbers is safe" do
    assert Day2.find_safe_level([5,4,3,2,1]) == 1
  end

  test "int list with increasing and decreasing numbers is not safe" do
    assert Day2.find_safe_level([5,41,3,2,1]) == 0
  end

  test "int list with increasing numbers and with delta greater than 2 is not safe" do
    assert Day2.find_safe_level([1,2,21,22,23]) == 0
  end

  test "find safe levels" do
    assert Day2.find_safe_levels([[7,6,4,2,1], [1,2,7,8,9], [9,7,6,2,1], [1,3,2,4,5], [8,6,4,4,1], [1,3,6,7,9]]) == 2
  end

  test "int list with problem dampener is safe when we can ignore one" do
    assert Day2.find_safe_level_with_dampener([8,6,4,4,1]) == 1
  end

  test "int list with problem dampener is safe when we can ignore one random" do
    assert Day2.find_safe_level_with_dampener([1, 4, 2, 3]) == 1
  end

  test "int list with problem dampener is safe when we can ignore one increasing" do
    assert Day2.find_safe_level_with_dampener([1,3,2,4,5]) == 1
  end

  test "int list with problem dampener is not safe when more than one is ignored" do
    assert Day2.find_safe_level_with_dampener([1,2,7,8,9]) == 0
  end

  # test "find safe levels with problem dampener" do
  #   assert Day2.find_safe_levels_with_dampener([[7,6,4,2,1], [1,2,7,8,9], [9,7,6,2,1], [1,3,2,4,5], [8,6,4,4,1], [1,3,6,7,9]]) == 4
  # end
end
