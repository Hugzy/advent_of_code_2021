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
    {:ok, content} = File.read("lib/test_input")
    parsed_content = content
    |> String.split("\r\n")
    |> Enum.map(&not_stupid_parse/1)
    parsed_content
    #|> Enum.map(&dupe/1)
    |> Enum.with_index()
    |> Enum.map(fn elem -> make_triplet(elem, parsed_content) end)
    |> Enum.reject(&is_nil/1)
    |> Enum.map(fn %{first: f, second: s, third: t} -> %{first: f, second: s, third: t, sum: f+s+t } end )


    #mapped_content = content
    #|> Enum.to_list()
    #mapped_content
    #|> Enum.map(fn x -> make_triplet(x, mapped_content) end)
    #|> Enum.reject(&is_nil/1)
    #|> print_result()


    #|> Enum.reduce(@default, fn elem, acc ->
    #    case acc.prev do
    #      nil -> %{count: acc.count, prev: elem, state: :NA}
    #      prev when elem > prev -> %{count: (acc.count + 1), prev: elem, state: :inc }
    #      prev when elem < prev -> %{count: acc.count, prev: elem, state: :dec}
    #    end
    # end)
    # |> print_result()
  end

  def dupe(elem) do
    {elem, elem, elem}
  end

  def make_triplet({first, index}, enumerable) do
    second = Enum.at(enumerable, index + 1)
    third = Enum.at(enumerable, index + 2)

    case {first, second, third} do
       {_,nil,_} -> nil
       {_,_,nil} -> nil
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
