# Start Writing the Dictionary

https://codestool.coding-gnome.com/courses/take/elixir-for-programmers-2/texts/28801067-start-writing-the-dictionary

## Exercise

This quick exercise will get you familiar with finding functions. Try the following in IEx:

    Bind the string "had we but world enough, and time"+ to a variable.

    ```elixir
    iex(14)> phrase = "had we but world enough, and time"
    "had we but world enough, and time"
    ```

    Use functions from the String module to

        Split it into two parts: the stuff before and the stuff after the comma.

        ```elixir
        iex(15)> String.split phrase, ~r/,/
        ["had we but world enough", " and time"]
        ```

        Split it into a list of characters, where each entry in the list is a single character string.

        ```elixir
        iex(21)> String.codepoints phrase
        ["h", "a", "d", " ", "w", "e", " ", "b", "u", "t", " ", "w", "o", "r", "l", "d",
         " ", "e", "n", "o", "u", "g", "h", ",", " ", "a", "n", "d", " ", "t", "i", "m",
         "e"]
        ```

        Split it into a list of characters, where each entry in the list is the integer representation of that character.

        > Couldn't understand this one, even after looking to PragDave solution, that I also used when trying to solve this. It says that each entry is the integer representation but I only see a single quoted string as the result... What am I missing?

        ```elixir
        iex(42)>  String.to_charlist phrase
        'had we but world enough, and time'
        ```

        reverse the string (hmmm... the first two words of the result are interesting)

        ```elixir
        iex(44)> String.reverse phrase
        "emit dna ,hguone dlrow tub ew dah"
        ```

        calculate the set of differences between this string and `"had we but bacon enough, and treacle"; you should get

        ```elixir
        [
          eq: "had we but ", del: "w", ins: "bac", eq: "o",
          del: "rld", ins: "n", eq: " enough, and t", del: "im",
          ins: "r", eq: "e", ins: "acle"
        ]
        ```

        My solution:

        ```elixir
        iex(47)> String.myers_difference phrase, phrase2
        [
          eq: "had we but ",
          del: "w",
          ins: "bac",
          eq: "o",
          del: "rld",
          ins: "n",
          eq: " enough, and t",
          del: "im",
          ins: "r",
          eq: "e",
          ins: "acle"
        ]
        ```
