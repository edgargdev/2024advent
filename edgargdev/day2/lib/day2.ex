defmodule Day2 do
  use Application

  def start(_type, _args) do
    main()
    Supervisor.start_link([], strategy: :one_for_one)
  end

  def main() do
    lines = parse_lines_from_files("input/day2.txt")
    # answer_part_one = find_safe_levels(lines)
    # answer_part_two = find_safe_levels_with_dampener(lines)
    #
    # IO.puts("Answer part one: #{answer_part_one}")
    # IO.puts("Answer part two: #{answer_part_two}")
  end

  def parse_lines_from_files(file_path) do
    File.read!(file_path)
    |> String.split("\n")
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(&string_line_to_int_list/1)
  end

  def string_line_to_int_list(line) do
    line
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
  end

  def find_safe_levels(lists) do
    lists
    |> Enum.map(&find_safe_level/1)
    |> Enum.sum
  end

  def find_safe_level(list) do
    safe = ListChecker.levels_are_safe(list)
    if safe do
      1
    else
      0
    end
  end

  def find_safe_levels_with_dampener(lists) do
    lists
    |> Enum.map(&find_safe_level_with_dampener/1)
    |> Enum.sum
  end

  def find_safe_level_with_dampener(list) do
    safe = ListChecker.levels_are_safe_with_dampener(list)
    if safe do
      1
    else
      0
    end
  end

end

defmodule ListChecker do
  @max_delta 3

  def levels_are_safe(list) when is_list(list) do
    (increasing?(list) or decreasing?(list)) && max_delta(list) <= @max_delta
  end

  def levels_are_safe_with_dampener(list) when is_list(list) do
    check_decreasing_with_one_allowed?(list, false) or check_increasing_with_one_allowed?(list, false)
  end

  defp increasing?([_]), do: true
  defp increasing?([a, b | rest]) when a < b, do: increasing?([b | rest])
  defp increasing?(_), do: false

  defp decreasing?([_]), do: true
  defp decreasing?([a, b | rest]) when a > b, do: decreasing?([b | rest])
  defp decreasing?(_), do: false

  defp max_delta([_]), do: 0
  defp max_delta([a, b | rest]) do
    delta = abs(a - b)
    max_delta = max_delta([b | rest])
    if delta > max_delta do
      delta
    else
      max_delta
    end
  end
  defp max_delta(_), do: 0

  defp check_increasing_with_one_allowed?([], _ignored), do: true
  defp check_increasing_with_one_allowed?([_], _ignored), do: true

  defp check_increasing_with_one_allowed?([a, b | rest], ignored) do
    cond do
      a < b -> 
        check_increasing_with_one_allowed?([b | rest], ignored) # Keep checking if the list is increasing

      not ignored ->
        # Allow skipping one breaking number, test both possibilities
        check_increasing_with_one_allowed?([b | rest], true) or 
        check_increasing_with_one_allowed?([a | rest], true)

      true ->
        # IO.puts("Breaking point: #{a} #{b}")
        false # Second breaking point, return false
    end
  end

  defp check_decreasing_with_one_allowed?([], _ignored), do: true
  defp check_decreasing_with_one_allowed?([_], _ignored), do: true
  defp check_decreasing_with_one_allowed?([a, b | rest], ignored) do
    # IO.puts("Checking a:#{a} b:#{b} rest: #{rest} ignored:#{ignored}")
    cond do
      a > b -> 
        check_decreasing_with_one_allowed?([b | rest], ignored) # Keep checking if the list is increasing

      not ignored ->
        # Allow skipping one breaking number, test both possibilities
        check_decreasing_with_one_allowed?([b | rest], true) or 
        check_decreasing_with_one_allowed?([a | rest], true)

      true ->
        false # Second breaking point, return false
    end
  end

  defp check_max_delta([_], _ignored), do: true
  defp check_max_delta([a, b | rest], ignored) do
    cond do
      abs(a - b) < @max_delta ->
        # Continue checking if the current pair's delta is valid
        check_max_delta([b | rest], ignored)

      not ignored ->
        # Allow skipping one breaking number, but ensure the list remains valid
        check_max_delta([b | rest], true) or
        (rest != [] and check_max_delta([a | tl(rest)], true))

      true ->
        # If already ignored, return false
        false
    end
  end
  defp check_max_delta(_list, _ignored), do: true
end
