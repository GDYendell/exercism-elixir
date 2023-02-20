defmodule Username do
  def _sanitize([]) do
    []
  end

  def _sanitize([char | tail]) do
    char =
      case char do
        ?ä -> [?a, ?e]
        ?ö -> [?o, ?e]
        ?ü -> [?u, ?e]
        ?ß -> [?s, ?s]
        char when char >= ?a and char <= ?z -> [char]
        ?_ -> [char]
        _ -> []
      end

    char ++ _sanitize(tail)
  end

  def sanitize(username) do
    _sanitize(username)
  end
end
