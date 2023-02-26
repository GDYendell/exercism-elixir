defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, & &1.price, :asc)
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &is_nil(&1.price))
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn item ->
      %{item | name: String.replace(item.name, old_word, new_word)}
    end)
  end

  def increase_quantity(item, increase) do
    %{
      item
      | quantity_by_size:
          Map.new(item.quantity_by_size, fn {size, stock} -> {size, stock + increase} end)
    }
  end

  def total_quantity(item) do
    Enum.reduce(Map.values(item.quantity_by_size), 0, fn size_count, total ->
      total + size_count
    end)
  end
end
