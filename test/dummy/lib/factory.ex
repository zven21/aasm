defmodule Dummy.Factory do
  use ExMachina.Ecto, repo: Dummy.Repo

  def order_factory do
    %Dummy.Order{
      state: "state_created"
    }
  end
end
