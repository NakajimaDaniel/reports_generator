defmodule ReportsGenerator do
  def build(filename) do
    # case File.read("reports/#{filename}") do
    #   {:ok, result} -> result
    #   {:error, error} -> error
    # end

    "reports/#{filename}"
    |> File.stream!()
    |> Enum.reduce(report_acc(), fn line, report ->
      [id, _food_name, price] = parse_line(line)
      Map.put(report, id, price)
    end)
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> List.update_at(2, &String.to_integer/1)
  end

  defp report_acc, do: Enum.into(1..30, %{}, fn x -> {Integer.to_string(x), 0} end)
end
