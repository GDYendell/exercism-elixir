defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      c when c in [' ', ?\s] -> 0b0000
      c when c in ['A', ?A] -> 0b0001
      c when c in ['C', ?C] -> 0b0010
      c when c in ['G', ?G] -> 0b0100
      c when c in ['T', ?T] -> 0b1000
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
    do_encode(dna)
  end

  defp do_encode([nucleotide | tail]) when length(tail) > 0 do
    <<do_encode(nucleotide)::bitstring, do_encode(tail)::bitstring>>
  end

  defp do_encode(dna) do
    <<encode_nucleotide(dna)::4>>
  end

  def decode(dna) do
    do_decode(dna)
  end

  defp do_decode(<<nucleotide::4, tail::bitstring>>) when tail != "" do
    do_decode(<<nucleotide::4>>) ++ do_decode(tail)
  end

  defp do_decode(nucleotide) do
    case nucleotide do
      <<0b0000::4>> -> ' '
      <<0b0001::4>> -> 'A'
      <<0b0010::4>> -> 'C'
      <<0b0100::4>> -> 'G'
      <<0b1000::4>> -> 'T'
    end
  end
end
