defmodule AasmTest do
  use ExUnit.Case
  doctest Aasm

  test "greets the world" do
    assert Aasm.hello() == :world
  end
end
