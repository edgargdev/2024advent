defmodule DayTwo do
  use Application

  def part_one do
    prepare_input()
    |> Enum.map(&is_row_safe?/1)
    |> Enum.count(& &1)
  end

  def part_two do
    prepare_input()
    |> Enum.map(fn row ->
      0..length(row)
      |> Enum.map(fn idx_to_drop ->
        # brute force, drop each index from the row and test if it's safe
        Enum.reject(Enum.with_index(row), fn {_, idx} -> idx == idx_to_drop end)
        |> Enum.map(fn {elem, _} -> elem end)
      end)
      |> Enum.map(&is_row_safe?/1)
      |> Enum.any?()
    end)
    |> Enum.count(& &1)
  end

  # Returns true if the row is safe, and false if not
  defp is_row_safe?(row) do
    [first, second | _] = row
    # allowable_range is what is tolerable when subtracting one element from the next in the list
    allowable_range = if first > second, do: 1..3, else: -1..-3

    row
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.all?(fn [first, second] -> (first - second) in allowable_range end)
  end

  # Returns each row of the input as a list of integers
  defp prepare_input() do
    Utils.parse_input("day_two.txt")
    |> Enum.map(&parse_ints/1)
  end

  defp parse_ints(raw_row) do
    raw_row
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
  end

  def main do
    IO.puts("Part one: #{part_one()}")
    IO.puts("Part two: #{part_two()}")
  end

  def start(_type, _args) do
    main()
    Supervisor.start_link([], strategy: :one_for_one)
  end
end
