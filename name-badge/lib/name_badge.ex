defmodule NameBadge do
  def print(id, name, department) do
    id_string =
      if is_nil(id) do
        ""
      else
        "[#{id}] - "
      end

    department_string =
      if is_nil(department) do
        " - OWNER"
      else
        " - #{String.upcase(department)}"
      end

    "#{id_string}#{name}#{department_string}"
  end
end
