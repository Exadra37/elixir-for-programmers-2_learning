defmodule PatternMatching do

  # @LINK https://codestool.coding-gnome.com/courses/take/elixir-for-programmers-2/texts/28816261-pattern-matching-and-function-calls

  ### EXERCISE 1

  def swap({a, b}) do
     {b, a}
  end

  # PragDave Solution
  #def swap({a, b}), do: {b, a}


  ### EXERCISE 2

  def same({a, a} = _params) do
    true
  end

  def same(_params) do
    false
  end

  # PragDave Solution
  def equal(a, a), do: true
  def equal(_, _), do: false

end
