defmodule AdventOfCode2021 do
  @default %{count: 0, prev: nil, state: :NA}

  @spec main1 :: :ok
  def main1() do
    {:ok, content} = File.read("lib/test_input")
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

  @spec main2 :: :ok
  def main2() do
    {:ok, content} = File.read("lib/actual_input")
    mapped_content = content
    |> String.split("\r\n")
    |> Enum.map(&not_stupid_parse/1)
    |> Enum.with_index()

    mapped_content
    |> Enum.map(fn x -> make_triplet(x, mapped_content) end)

    #|> Enum.reduce(@default, fn elem, acc ->
    #    case acc.prev do
    #      nil -> %{count: acc.count, prev: elem, state: :NA}
    #      prev when elem > prev -> %{count: (acc.count + 1), prev: elem, state: :inc }
    #      prev when elem < prev -> %{count: acc.count, prev: elem, state: :dec}
    #    end
    # end)
    # |> print_result()
  end

  def make_triplet({first, index}, enumerable) do
    {second, _} = Enum.at(enumerable, index + 1)
    {third, _} = Enum.at(enumerable, index + 2)

    case {first, second, third} do
       {_,nil,_} ->
       {_,_,nil} -> _
       {f, s, t} -> %{first: f, second: s, third: t}
    end


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
