defmodule FileSniffer do
  @file_specs [
    %{
      extension: "exe",
      media_type: "application/octet-stream",
      signature: <<0x7F, 0x45, 0x4C, 0x46>>
    },
    %{
      extension: "bmp",
      media_type: "image/bmp",
      signature: <<0x42, 0x4D>>
    },
    %{
      extension: "png",
      media_type: "image/png",
      signature: <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A>>
    },
    %{
      extension: "jpg",
      media_type: "image/jpg",
      signature: <<0xFF, 0xD8, 0xFF>>
    },
    %{
      extension: "gif",
      media_type: "image/gif",
      signature: <<0x47, 0x49, 0x46>>
    }
  ]

  def type_from_extension(extension) do
    @file_specs
    # Find the file spec with the given extension, or empty
    |> Enum.find(%{}, fn file_spec ->
      file_spec.extension == extension
    end)
    # Get the media type of the found file spec, or nil if empty
    |> Map.get(:media_type)
  end

  defp extension_from_binary(file_binary) do
    @file_specs
    # Find the file spec with a signature that matches the file binary, or empty
    |> Enum.find(%{}, fn file_spec ->
      String.starts_with?(file_binary, file_spec.signature)
    end)
    # Get the extension of the found file spec, or nil empty
    |> Map.get(:extension)
  end

  def type_from_binary(file_binary) do
    file_binary |> extension_from_binary() |> type_from_extension()
  end

  def verify(file_binary, extension) do
    if extension_from_binary(file_binary) == extension do
      {:ok, type_from_extension(extension)}
    else
      {:error, "Warning, file format and file extension do not match."}
    end
  end
end
