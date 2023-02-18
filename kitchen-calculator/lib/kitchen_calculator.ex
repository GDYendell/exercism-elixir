defmodule KitchenCalculator do
  def get_volume({_, volume}) do
    volume
  end

  def to_milliliter({:milliliter, milliliters}) do
    {:milliliter, milliliters}
  end

  def to_milliliter({:cup, cups}) do
    {:milliliter, cups * 240}
  end

  def to_milliliter({:fluid_ounce, ounces}) do
    {:milliliter, ounces * 30}
  end

  def to_milliliter({:tablespoon, tablespoons}) do
    {:milliliter, tablespoons * 15}
  end

  def to_milliliter({:teaspoon, teaspoons}) do
    {:milliliter, teaspoons * 5}
  end

  def from_milliliter(volume_pair, :milliliter) do
    volume_pair
  end

  def from_milliliter({:milliliter, milliliters}, :cup) do
    {:cup, milliliters / 240}
  end

  def from_milliliter({:milliliter, milliliters}, :fluid_ounce) do
    {:fluid_ounce, milliliters / 30}
  end

  def from_milliliter({:milliliter, milliliters}, :tablespoon) do
    {:tablespoon, milliliters / 15}
  end

  def from_milliliter({:milliliter, milliliters}, :teaspoon) do
    {:teaspoon, milliliters / 5}
  end

  def convert(volume_pair, unit) do
    from_milliliter(to_milliliter(volume_pair), unit)
  end
end
