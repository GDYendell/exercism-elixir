defmodule WineCellar do
  def explain_colors do
    [
      white: "Fermented without skin contact.",
      red: "Fermented with skin contact using dark-colored grapes.",
      rose: "Fermented with some skin contact, but not enough to qualify as a red wine."
    ]
  end

  def filter(cellar, color, opts \\ []) do
    Keyword.get_values(cellar, color)
    |> Enum.reject(fn {_, year, _} ->
      !is_nil(opts[:year]) and year != opts[:year]
    end)
    |> Enum.reject(fn {_, _, country} ->
      !is_nil(opts[:country]) and country != opts[:country]
    end)
  end
end
