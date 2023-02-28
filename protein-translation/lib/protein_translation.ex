defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  def of_rna(rna) do
    proteins =
      codons_from_rna(rna)
      |> Enum.map(&of_codon/1)
      |> Enum.map(fn {status, codon} -> if status == :ok, do: codon, else: nil end)
      |> Enum.take_while(fn codon -> codon != "STOP" end)

    if Enum.any?(proteins, &is_nil/1) do
      {:error, "invalid RNA"}
    else
      {:ok, proteins}
    end
  end

  defp codons_from_rna(rna) do
    chunk_rna(rna)
    |> Enum.reject(fn codon -> codon == "" end)
    |> Enum.map(fn codon -> if rem(String.length(codon), 3) == 0, do: codon, else: nil end)
  end

  defp chunk_rna(<<codon::binary-3, rest::bitstring>>) do
    [codon | chunk_rna(rest)]
  end

  defp chunk_rna(<<rest::bitstring>>) do
    [rest]
  end

  @doc """
  Given a codon, return the corresponding protein
  """
  @spec of_codon(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def of_codon(codon) do
    case codon do
      c when c in ["UGU", "UGC"] -> {:ok, "Cysteine"}
      c when c in ["UUA", "UUG"] -> {:ok, "Leucine"}
      "AUG" -> {:ok, "Methionine"}
      c when c in ["UUU", "UUC"] -> {:ok, "Phenylalanine"}
      c when c in ["UCU", "UCC", "UCA", "UCG"] -> {:ok, "Serine"}
      "UGG" -> {:ok, "Tryptophan"}
      c when c in ["UAU", "UAC"] -> {:ok, "Tyrosine"}
      c when c in ["UAA", "UAG", "UGA"] -> {:ok, "STOP"}
      _ -> {:error, "invalid codon"}
    end
  end
end
