defmodule FileSniffer do
  def type_from_extension(extension) do
    case extension do
      "exe" -> "application/octet-stream"
      "bmp" -> "image/bmp"
      "png" -> "image/png"
      "jpg" -> "image/jpg"
      "gif" -> "image/gif"
      _ -> nil
    end
  end

  def type_from_binary(file_binary) do
    file_binary |> extension_from_binary() |> type_from_extension()
  end

  defp extension_from_binary(<<0x7F::8, 0x45::8, 0x4C::8, 0x46::8, _::bitstring>>) do
    "exe"
  end

  defp extension_from_binary(<<0x42::8, 0x4D::8, _::bitstring>>) do
    "bmp"
  end

  defp extension_from_binary(
         <<0x89::8, 0x50::8, 0x4E::8, 0x47::8, 0x0D::8, 0x0A::8, 0x1A::8, 0x0A::8, _::bitstring>>
       ) do
    "png"
  end

  defp extension_from_binary(<<0xFF::8, 0xD8::8, 0xFF::8, _::bitstring>>) do
    "jpg"
  end

  defp extension_from_binary(<<0x47::8, 0x49::8, 0x46::8, _::bitstring>>) do
    "gif"
  end

  defp extension_from_binary(<<_::bitstring>>) do
    nil
  end

  def verify(file_binary, extension) do
    if extension_from_binary(file_binary) == extension do
      {:ok, type_from_extension(extension)}
    else
      {:error, "Warning, file format and file extension do not match."}
    end
  end
end
