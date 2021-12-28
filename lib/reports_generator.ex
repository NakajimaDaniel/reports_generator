defmodule ReportsGenerator do
  def build(filename) do
    # case File.read("reports/#{filename}") do
    #   {:ok, result} -> result
    #   {:error, error} -> error
    # end

    "reports/#{filename}"
    |> File.stream!()
    |> Enum.map(fn line -> parse_line(line) end)
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> List.update_at(2, &String.to_integer/1)
  end
end
