defmodule Utils do
  def parse_input(filename) do
    File.read!("input/#{filename}")
    |> String.split("\n", trim: true)
    |> Enum.map(&String.trim/1)
  end
end
