# AGENTS - AN ABSTRACTION OVER STATE

https://codestool.coding-gnome.com/courses/take/elixir-for-programmers-2/texts/29542517-agents-an-abstration-over-state

## AGENT STATE

Starting a linked agent and passing to it the required anonymous function to handle the state:

```elixir
{:ok, counter} = Agent.start_link(fn -> 0 end)
```

Getting the state from an Agent, that also requires an anonymous function to be passed in order to read the state:

```elixir
Agent.get(counter, fn state -> state end)
```

To update the state we also need to pass an anonymous function:

```elixir
Agent.update(counter, fn state -> state + 1 end)
```

The Agent update funtions doesn't return the new state, we will need to retrieve the new state with another call to `Agent.get/2` or instead we can use the Agent get and update function:

```elixir
Agent.get_and_update(counter, fn state -> state = state + 1; {state, state} end)
```

Oddly, the PragDave example as it is in the Elixir docs is returning the old state:

```elixir
Agent.get_and_update(counter, fn state -> {state, state + 1} end)
```

In order to try to understand whyd the Elixir docs exmple is done as it is I have asked [this question](https://elixirforum.com/t/agent-get-and-update-2-docs-example-doesnt-return-what-i-expect/46704) in the Elixir forum.

### Iex Playground

Playing around in `iex` with the above examples:

```elixir
iex(3)> {:ok, counter} = Agent.start_link(fn -> 0 end)
{:ok, #PID<0.110.0>}

iex(5)> Agent.get(counter, fn state -> state end)
0
iex(6)> Agent.get(counter, fn state -> state end)
0
iex(7)> Agent.update(counter, fn state -> state + 1 end)
:ok
iex(8)> Agent.get(counter, fn state -> state end)
1
iex(9)> Agent.update(counter, fn state -> state + 1 end)
:ok
iex(10)> Agent.get(counter, fn state -> state end)
2
iex(12)> Agent.get_and_update(counter, fn state -> {state, state + 1} end)
2
iex(13)> Agent.get(counter, fn state -> state end)
3
iex(14)> Agent.get_and_update(counter, fn state -> state = state + 1; {state, state} end)
4
iex(15)> Agent.get_and_update(counter, fn state -> state = state + 1; {state, state} end)
5
iex(16)> Agent.get_and_update(counter, fn state -> state = state + 1; {state, state} end)
```


## AGENTS ENCAPSULATION

To avoid abusing the functionality of the Agent, after all we just need to pass in an anonymous function, it's important that we don't leak the Agent usage direcctly through our code base, therefore we should encapsulate it's use in an Elixr module.

For, example PragDave gives this example in is Rant:

```elixir
defmodule HitCount do

  def start() do
    Agent.start_link(fn -> 0 end)
  end

  def record_hit(agent) do
    Agent.update(agent, &(&1 + 1))
  end

  def get_count(agent) do
    Agent.get(agent, &(&1))
  end
```

As PragDave says an Agent should be treated as an implementation detail and we should just use the API we built (Module HitCount) for accessing it thorough our code.
