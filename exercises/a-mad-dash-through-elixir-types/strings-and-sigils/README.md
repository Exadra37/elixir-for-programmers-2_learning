# STRINGS AND SIGILS

https://codestool.coding-gnome.com/courses/take/elixir-for-programmers-2/texts/28815658-strings-and-sigils

## Exercises


Back into IEx you go…

* The function Time.utc_now returns the UTC time. Interpolate it into a string using both a double-quote literal and a sigil.

    Solution:

    ```elixir
    iex(78)> string1 = ~s/time: #{now}/
    "time: 15:57:48.961613"
    iex(79)> string2 = "time: #{now}"
    "time: 15:57:48.961613"
    ```

* When does the interpolated expression get evaluated?

    Reply: When it's invoked during runtime.
    PragDave reply: So the interpolation happens once, when the string is created

* You have to output the instructions on how to interpolate expressions into strings. Use IO.puts to output:
    For example, 1 + 2 = #{ 1 + 2 }

    Solution:

    ```elixir
    iex(81)> IO.puts ~S'1 + 2 = #{ 1 + 2 }'
    1 + 2 = #{ 1 + 2 }
    :ok
    ```

    PragDave Solution:

    ```elixir
    iex(9)> IO.puts "1 + 2 = \#{ 1 + 2 }"
    1 + 2 = #{ 1 + 2 }
    :ok
    ```

* Use a sigil to transform "now is the time" into the list

    ```elixir
    [ "now", "is", "the", "time" ]
    ```

    Solution: Failed to find one, but not tried hard :(

    PragDave Solution:

    ```elixir
    iex(11)> ~w[now is the time]
    ["now", "is", "the", "time"]
    ```
