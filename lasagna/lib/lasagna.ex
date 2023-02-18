defmodule Lasagna do
  def expected_minutes_in_oven() do
    40
  end

  def remaining_minutes_in_oven(elapsed_cook_time) do
    expected_minutes_in_oven() - elapsed_cook_time
  end

  def preparation_time_in_minutes(layer_count) do
    2 * layer_count
  end

  def total_time_in_minutes(layer_count, elapsed_cook_time) do
    preparation_time_in_minutes(layer_count) + elapsed_cook_time
  end

  def alarm do
    "Ding!"
  end
end
