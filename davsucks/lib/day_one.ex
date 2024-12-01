defmodule DayOne do
  def part_one do
    prepare_input()
    |> Enum.zip()
    |> Enum.map(fn {first, second} -> abs(first - second) end)
    |> Enum.sum()
  end

  def part_two do
    [listOne, listTwo] = prepare_input()

    # Find occurrence of each item
    Enum.map(listOne, fn item -> Enum.count(listTwo, &(&1 == item)) end)
    |> Enum.zip(listOne)
    |> Enum.map(fn {first, second} -> first * second end)
    |> Enum.sum()
  end

  # Returns each column of the input as a list of integers
  defp prepare_input() do
    Utils.parse_input("day_one.txt")
    |> Enum.map(&String.split(&1, ~r/\s+/))
    |> Enum.map(&List.to_tuple/1)
    |> Enum.unzip()
    |> Tuple.to_list()
    # Enum doesn't work with tuples, hence to_list above
    |> Enum.map(&parse_ints/1)
  end

  defp parse_ints(list) do
    list |> Enum.map(&String.to_integer/1) |> Enum.sort()
  end
end
