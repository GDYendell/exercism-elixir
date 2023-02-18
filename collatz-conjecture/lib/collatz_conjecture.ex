defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input) when is_number(input) and input > 0 do
    _calc(input)
  end

  def _calc(1) do
    0
  end

  def _calc(input) when rem(input, 2) == 1 do
    calc(input * 3 + 1) + 1
  end

  def _calc(input) when rem(input, 2) == 0 do
    calc(Integer.floor_div(input, 2)) + 1
  end
end
