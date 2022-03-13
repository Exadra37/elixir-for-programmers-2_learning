# REGULAR EXPRESSIONS



## Exercises

Time to explore the functions in the Regex module:

* Write an expression that returns true if a string contains an a, followed by any character, then a c (so abc, and arc will return true, and ace will not).

    Solution:

    ```elixir
    iex(106)> str1 = "abc"
    "abc"
    iex(107)> str2 = "arc"
    "arc"
    iex(108)> str1 =~ ~r/a.*c/
    true
    iex(109)> str2 =~ ~r/a.*c/
    true
    iex(110)> "abdef" =~ ~r/a.*c/
    false
    iex(111)> "abdec" =~ ~r/a.*c/
    true
    ```

* Write an expression that takes a string and replaces every occurrence of cat with dog.

    Solution:

    ```elixir
    iex(134)> pets = "my cat is a good cat"
    "my cat is a good cat"
    iex(135)> String.replace pets, ~r/cat/, "dog"
    "my dog is a good dog"

    ```

* Do the same, but only replace the first occurrence.

    Solution: Failed to find one, because I have not read the String.replace docs, just looked at the examples on it.

    PragDave Solution:

    ```elixir
    iex> "cats like catnip" |> String.replace(~r/cat/, "dog", global: false)
    "dogs like catnip"
    ```
