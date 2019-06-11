# AASM

> The finite state machine implementations for Elixir.

## Table of contents

* [Getting started](#getting-started)
* [Examples](#examples)
* [TODO](#todo)
* [Contributing](#contributing)
* [Make a pull request](#make-a-pull-request)
* [License](#license)
* [Credits](#credits)

## Getting started

* The package can be installed by adding `aasm` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:aasm, "~> 0.2.0"}
  ]
end
```

## Examples

```elixir
defmodule Dummy.Order do
  @moduledoc """
  Order model
  """

  use Ecto.Schema
  import AASM

  aasm :state do
    state(~w(state_created state_assigned state_finished state_closed)a)

    event(:handle_assigned, %{from: ~w(state_created)a, to: :state_assigned}, fn changeset ->
      changeset
    end)

    event(:handle_finished, %{from: ~w(state_assigned)a, to: :state_finished}, fn changeset ->
      changeset
    end)

    event(
      :handle_closed,
      %{from: ~w(state_created state_assigned state_finished)a, to: :state_closed},
      fn changeset -> changeset end
    )
  end

  schema "orders" do
    field(:state, :string)
  end
end
```

## TODO

* [ ] Support multi db column.
* [ ] Add before_event.
* [ ] Initial value

## Contributing

Bug report or pull request are welcome.

## Make a pull request

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Please write unit test with your code if necessary.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Credits

* [aasm](https://github.com/aasm/aasm) - State machines for Ruby classes.
* [ecto_state_machine](https://github.com/asiniy/ecto_state_machine) - Other state machine for elixir.