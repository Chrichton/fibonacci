defmodule Fibonacci do
  alias Fibonacci.Memoize

  def fib(0), do: 0
  def fib(1), do: 1

  def fib(n) do
    get(n - 2) + get(n - 1)
  end

  defp get(n) do
    fibn = Memoize.get(n)

    if fibn do
      fibn
    else
      fibn = fib(n)
      Memoize.set(n, fibn)
      fibn
    end
  end
end
