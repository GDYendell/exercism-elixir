defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) when length(strand1) != length(strand2) do
    {:error, "strands must be of equal length"}
  end

  def hamming_distance(strand1, strand2) do
    {:ok, Enum.zip_with(strand1, strand2, &base_difference/2) |> Enum.sum()}
  end

  defp base_difference(base1, base2) do
    case base1 == base2 do
      true -> 0
      false -> 1
    end
  end
end
