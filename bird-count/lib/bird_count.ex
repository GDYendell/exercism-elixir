defmodule BirdCount do
  def today([]) do
    nil
  end

  def today([today | _past]) do
    today
  end

  def increment_day_count([]) do
    [1]
  end

  def increment_day_count([today | past]) do
    [today + 1 | past]
  end

  def has_day_without_birds?([]) do
    false
  end

  def has_day_without_birds?([today | past]) do
    today == 0 or has_day_without_birds?(past)
  end

  def total([]) do
    0
  end

  def total([today | past]) do
    today + total(past)
  end

  def busy_days([]) do
    0
  end

  def busy_days([today | past]) do
    _busy_day(today) + busy_days(past)
  end

  def _busy_day(bird_count) do
    if bird_count >= 5, do: 1, else: 0
  end
end
