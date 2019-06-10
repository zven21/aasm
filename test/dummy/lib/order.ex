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
