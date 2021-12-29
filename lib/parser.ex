defmodule ReportsGenerator.Parser do
  # case File.read("reports/#{filename}") do
  #   {:ok, result} -> result
  #   {:error, error} -> error
  # end

  def parse_file(filename) do
    "reports/#{filename}"
    |> File.stream!()
    |> Stream.map(fn line -> parse_line(line) end)
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> List.update_at(2, &String.to_integer/1)
  end
end
