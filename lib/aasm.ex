defmodule AASM do
  @moduledoc """
  The finite state machine implementations for Elixir.
  """

  defmacro aasm(field, body) do
    quote do
      alias Ecto.Changeset

      def aasm_field do
        unquote(field)
      end

      def current_state(record) do
        case record |> Map.fetch(aasm_field()) do
          {:ok, state} -> String.to_atom(state)
          _ -> nil
        end
      end

      defp validate_state_transition(changeset, from_states, to_state) do
        cr_state = current_state(changeset.data)

        if Enum.member?(from_states, cr_state) && state_defined?(to_state) do
          changeset
        else
          changeset
          |> Changeset.add_error(
            aasm_field(),
            "You can't move #{aasm_field()} from :#{cr_state} to :#{to_state}"
          )
        end
      end

      unquote(body[:do])
    end
  end

  defmacro state(states) do
    quote do
      def states do
        unquote(states)
      end

      def state_defined?(state) do
        states()
        |> Enum.member?(state)
      end
    end
  end

  defmacro event(event, opts, callback) do
    quote do
      alias Ecto.Changeset

      def unquote(:"#{event}")(record) do
        %{from: from_states, to: to_state} = unquote(opts)

        record
        |> Changeset.change(%{aasm_field() => Atom.to_string(to_state)})
        |> validate_state_transition(from_states, to_state)
        |> unquote(callback).()
      end

      def unquote(:"can_#{event}?")(record) do
        %{from: from_states, to: to_state} = unquote(opts)
        cr_state = current_state(record)
        Enum.member?(from_states, cr_state) && state_defined?(to_state)
      end
    end
  end
end
