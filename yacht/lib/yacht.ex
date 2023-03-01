defmodule Yacht do
  @type category ::
          :ones
          | :twos
          | :threes
          | :fours
          | :fives
          | :sixes
          | :full_house
          | :four_of_a_kind
          | :little_straight
          | :big_straight
          | :choice
          | :yacht

  @doc """
  Calculate the score of 5 dice using the given category's scoring method.
  """
  @spec score(category :: category(), dice :: [integer]) :: integer
  def score(category, dice) do
    sorted_dice = Enum.sort(dice)
    max(_score(category, sorted_dice), _score(category, Enum.reverse(sorted_dice)))
  end

  defp _score(category, dice) when category in [:ones, :twos, :threes, :fours, :fives, :sixes] do
    case category do
      :ones -> _score_die(dice, 1)
      :twos -> _score_die(dice, 2)
      :threes -> _score_die(dice, 3)
      :fours -> _score_die(dice, 4)
      :fives -> _score_die(dice, 5)
      :sixes -> _score_die(dice, 6)
    end
  end

  defp _score(:full_house, [d1, d1, d2, d2, d2]) when d1 != d2 do
    d1 * 2 + d2 * 3
  end

  defp _score(:four_of_a_kind, [d, d, d, d, _]) do
    d * 4
  end

  defp _score(:little_straight, [1, 2, 3, 4, 5]) do
    30
  end

  defp _score(:big_straight, [2, 3, 4, 5, 6]) do
    30
  end

  defp _score(:choice, dice) do
    Enum.sum(dice)
  end

  defp _score(:yacht, [d, d, d, d, d]) do
    50
  end

  defp _score(_, _) do
    0
  end

  defp _score_die(dice, die) do
    Enum.count(dice, &(&1 == die)) * die
  end
end
