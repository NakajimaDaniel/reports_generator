defmodule ReportsGenerator do
  alias ReportsGenerator.Parser

  @available_foods [
    "açaí",
    "churrasco",
    "esfirra",
    "hambúrguer",
    "pastel",
    "pizza",
    "prato_feito",
    "sushi"
  ]

  @options [
    "foods",
    "users"
  ]

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(report_acc(), fn line, report -> sum_values(line, report) end)
  end

  def fetch_higher_cost(report, option) when option in @options do
    {:ok, Enum.max_by(report[option], fn {_key, value} -> value end)}
  end

  def fetch_higher_cost(_report, _option), do: {:error, "invalid option"}

  defp sum_values([id, food_name, price], %{"users" => users, "foods" => foods} = report) do
    users = Map.put(users, id, users[id] + price)
    foods = Map.put(foods, food_name, foods[food_name] + 1)

    report
    |> Map.put("users", users)
    |> Map.put("foods", foods)

    # %{report | "users" => users, "foods" => foods}
  end

  defp report_acc do
    users = Enum.into(1..30, %{}, fn x -> {Integer.to_string(x), 0} end)
    foods = Enum.into(@available_foods, %{}, fn x -> {x, 0} end)

    %{"users" => users, "foods" => foods}
  end
end
