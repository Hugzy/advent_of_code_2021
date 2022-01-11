defmodule AdventOfCode2021 do
  @default %{count: 0, prev: nil, state: :NA}

  @spec main :: :ok
  def main() do
    {:ok, content} = File.read("lib/actual_input")
    content
    |> String.split("\r\n")
    |> Enum.map(&not_stupid_parse/1)
    |> Enum.reduce(@default, fn elem, acc ->
        case acc.prev do
          nil -> %{count: acc.count, prev: elem, state: :NA}
          prev when elem > prev -> %{count: (acc.count + 1), prev: elem, state: :inc }
          prev when elem < prev -> %{count: acc.count, prev: elem, state: :dec}
        end
     end)
    |> print_result()
  end

  @spec not_stupid_parse(binary) :: integer
  def not_stupid_parse(s) do
    {i, _} = Integer.parse(s)
    i
  end

  @spec print_result(any) :: :ok
  def print_result(result) do
   IO.write("> Result is ")
   IO.inspect(result)
   :ok
  end

end
