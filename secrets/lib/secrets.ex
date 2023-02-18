defmodule Secrets do
  def secret_add(secret) do
    add = fn value -> value + secret end
    add
  end

  def secret_subtract(secret) do
    subtract = fn value -> value - secret end
    subtract
  end

  def secret_multiply(secret) do
    multiply = fn value -> value * secret end
    multiply
  end

  def secret_divide(secret) do
    divide = fn value -> Integer.floor_div(value, secret) end
    divide
  end

  def secret_and(secret) do
    and_ = fn value -> Bitwise.&&&(value, secret) end
    and_
  end

  def secret_xor(secret) do
    xor_ = fn value -> Bitwise.^^^(value, secret) end
    xor_
  end

  def secret_combine(secret_function1, secret_function2) do
    combine = fn value -> secret_function2.(secret_function1.(value)) end
    combine
  end
end
