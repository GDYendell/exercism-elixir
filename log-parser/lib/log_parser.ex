defmodule LogParser do
  def valid_line?(line) do
    line =~ ~r/^\[?(DEBUG|INFO|WARNING|ERROR)\].*$/
  end

  def split_line(line) do
    String.split(line, ~r/<[~,*,=,-]*>/)
  end

  def remove_artifacts(line) do
    String.replace(line, ~r/end-of-line\d+/i, "")
  end

  def tag_with_user_name(line) do
    if Regex.match?(~r/User/, line) do
      # Find non-whitespace username, wrapped in whitespace characters, following `User`
      Regex.run(~r/User\s*(\S*)\s*/, line)
      # Extract match group
      |> Enum.at(1)
      # Add to prefix
      |> (&Kernel.<>("[USER] ", &1)).()
      # Add a space
      |> Kernel.<>(" ")
      # Add the original line
      |> Kernel.<>(line)
    else
      line
    end
  end
end
