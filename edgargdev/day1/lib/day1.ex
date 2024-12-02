defmodule Day1 do
  use Application

  def start(_type, _args) do
    Day1.main()
    Supervisor.start_link([], strategy: :one_for_one)
  end

  def main do
    file_contents = read_file("input/day1.txt")

    IO.puts("Solving part 1")

    numbered_lists =
      generate_lists(file_contents)
      |> convert_to_ints()

    answer_part_one =
      numbered_lists
      |> order_lists()
      |> find_sum_of_differences()

    answer_part_two =
      numbered_lists
      |> build_occurences_map()
      |> calculate_similarity_score()

    IO.puts("Part1 answer: #{answer_part_one}")
    IO.puts("Part2 answer: #{answer_part_two}")
  end

  def read_file(file) do
    File.read!(file)
  end

  def generate_lists(file_contents) do
    file_contents
    |> String.split("\n", trim: true)
    |> Enum.reduce({[], []}, fn line, {list1, list2} ->
      [first, second] = String.split(line, " ", trim: true)
      {[first | list1], [second | list2]}
    end)
    |> then(fn {list1, list2} -> {Enum.reverse(list1), Enum.reverse(list2)} end)
  end

  def convert_to_ints(lists) do
    lists
    |> then(fn {list1, list2} ->
      {list1 |> Enum.map(&String.to_integer/1), list2 |> Enum.map(&String.to_integer/1)}
    end)
  end

  def order_lists(lists) do
    lists
    |> then(fn {list1, list2} -> {list1 |> Enum.sort(), list2 |> Enum.sort()} end)
  end

  def find_sum_of_differences(lists) do
    lists
    |> then(fn {list1, list2} -> Enum.zip(list1, list2) end)
    |> Enum.reduce(0, fn {first, second}, acc -> acc + abs(second - first) end)
  end

  def build_occurences_map(lists) do
    lists
    |> then(fn {list1, list2} ->
      {list1, Enum.reduce(list2, %{}, fn num, acc -> Map.update(acc, num, 1, &(&1 + 1)) end)}
    end)
  end

  def calculate_similarity_score(lists) do
    lists
    |> then(fn {list1, list2} ->
      Enum.reduce(list1, 0, fn num, acc -> acc + num * Map.get(list2, num, 0) end)
    end)
  end
end
