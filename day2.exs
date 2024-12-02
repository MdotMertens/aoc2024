defmodule Day2 do
  defp remove_one(list) do
    Enum.with_index(list)
    |> Enum.map(fn {_, idx} -> List.delete_at(list, idx) end)
  end

  defp all_increasing?(list) do
    list
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.all?(fn [a, b] -> a <= b end)
  end

  defp all_decreasing?(list) do
    list
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.all?(fn [a, b] -> a >= b end)
  end

  defp valid_line?(line) do
    line
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.all?(fn [a, b] -> abs(a - b) >= 1 && abs(a - b) <= 3 end)
    && (all_increasing?(line) || all_decreasing?(line))
  end

  defp fixable_line?(line) do
    Enum.any?(line, fn _ ->
      line
      |> remove_one()
      |> Enum.any?(&valid_line?/1)
    end)
  end

  def solve_withut_removal() do
    File.stream!("day2.input")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.split/1)
    |> Enum.map(fn x -> Enum.map(x, &String.to_integer/1) end)
    |> Enum.reduce(0, fn line, acc ->
      result = valid_line?(line)
      if result, do: acc + 1, else: acc
    end)
    |> IO.inspect()
  end

  def solve_with_removal() do
    File.stream!("day2.input")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.split/1)
    |> Enum.map(fn x -> Enum.map(x, &String.to_integer/1) end)
    |> Enum.reduce(0, fn line, acc ->
      if valid_line?(line) || fixable_line?(line) do
        acc + 1
      else
        acc
      end
    end)
    |> IO.inspect()
  end
end

Day2.solve_with_removal()
Day2.solve_withut_removal()

