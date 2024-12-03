result =
  File.stream!("day3.input")
  |> Enum.map(&String.trim/1) 
  |> Enum.flat_map(fn line -> 
    Regex.scan(~r/mul\((\d+),(\d+)\)|do\(\)|don't\(\)/, line) 
  end)  
  |> Enum.reduce({true, 0}, fn
    ["mul(" <> _rest, num1, num2], {mul_enabled, acc} when mul_enabled -> 
      {mul_enabled, acc + (String.to_integer(num1) * String.to_integer(num2))}
    ["do()"], {_, acc} -> 
      {true, acc}
    ["don't()"], {_, acc} -> 
      {false, acc}
    _, acc -> acc
  end)
  |> elem(1) 
IO.inspect(result)
