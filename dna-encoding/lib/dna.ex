defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      ?\s -> 0b0000
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0000 -> ?\s
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
    end
  end

  def encode(dna) do
    do_encode(dna, <<>>)
  end

  defp do_encode([nucleotide | tail], encoded) do
    do_encode(tail, <<encoded::bitstring, encode_nucleotide(nucleotide)::4>>)
  end

  defp do_encode([], encoded) do
    encoded
  end

  def decode(dna) do
    do_decode(dna, '')
  end

  defp do_decode(<<nucleotide::4, tail::bitstring>>, decoded) do
    do_decode(tail, decoded ++ [decode_nucleotide(nucleotide)])
  end

  defp do_decode(<<0::0>>, decoded) do
    decoded
  end
end
