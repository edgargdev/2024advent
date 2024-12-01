defmodule Utils do
  def parse_input(filename) do
    File.read!("input/#{filename}")
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.filter(&(&1 != ""))
  end
end
