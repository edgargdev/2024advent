defmodule Day1 do
  use Application

  def start(_type, _args) do
    Day1.main()
    Supervisor.start_link([], strategy: :one_for_one)
  end

  def main do
    IO.puts "Hello, world!"
    file_contents = read_file("input/day1.txt")
    answer = generate_lists(file_contents)
      |> convert_to_ints()
      |> order_lists()
      |> find_sum_of_differences()
    IO.puts "Answer: #{answer}"
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
    |> then(fn {list1, list2} -> {list1 |> Enum.map(&String.to_integer/1), list2 |> Enum.map(&String.to_integer/1)} end)
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
end

