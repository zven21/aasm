defmodule AASMTest do
  use ExUnit.Case

  import Dummy.Factory

  alias Dummy.Order

  setup_all do
    {
      :ok,
      created_order: insert(:order, %{state: "state_created"}),
      assigned_order: insert(:order, %{state: "state_assigned"}),
      finished_order: insert(:order, %{state: "state_finished"}),
      closed_order: insert(:order, %{state: "state_closed"})
    }
  end

  test "states" do
    assert Order.states() == [:state_created, :state_assigned, :state_finished, :state_closed]
  end

  describe "events" do
    test "#assigned", context do
      changeset = Order.handle_assigned(context[:created_order])
      assert changeset.valid? == true
      assert changeset.changes.state == "state_assigned"

      changeset = Order.handle_assigned(context[:assigned_order])
      assert changeset.valid? == false

      assert changeset.errors == [
               state: {"You can't move state from :state_assigned to :state_assigned", []}
             ]

      changeset = Order.handle_assigned(context[:finished_order])
      assert changeset.valid? == false

      assert changeset.errors == [
               state: {"You can't move state from :state_finished to :state_assigned", []}
             ]

      changeset = Order.handle_assigned(context[:closed_order])
      assert changeset.valid? == false

      assert changeset.errors == [
               state: {"You can't move state from :state_closed to :state_assigned", []}
             ]
    end

    test "#finished", context do
      changeset = Order.handle_finished(context[:created_order])
      assert changeset.valid? == false

      assert changeset.errors == [
               state: {"You can't move state from :state_created to :state_finished", []}
             ]

      changeset = Order.handle_finished(context[:assigned_order])
      assert changeset.valid? == true

      assert changeset.errors == []

      changeset = Order.handle_finished(context[:finished_order])
      assert changeset.valid? == false

      assert changeset.errors == [
               state: {"You can't move state from :state_finished to :state_finished", []}
             ]

      changeset = Order.handle_finished(context[:closed_order])
      assert changeset.valid? == false

      assert changeset.errors == [
               state: {"You can't move state from :state_closed to :state_finished", []}
             ]
    end

    test "#closed", context do
      changeset = Order.handle_closed(context[:created_order])
      assert changeset.valid? == true
      assert changeset.changes.state == "state_closed"

      changeset = Order.handle_closed(context[:assigned_order])
      assert changeset.valid? == true
      assert changeset.changes.state == "state_closed"

      changeset = Order.handle_closed(context[:finished_order])
      assert changeset.valid? == true
      assert changeset.changes.state == "state_closed"

      changeset = Order.handle_closed(context[:closed_order])
      assert changeset.valid? == false

      assert changeset.errors == [
               state: {"You can't move state from :state_closed to :state_closed", []}
             ]
    end
  end

  describe "#can_*" do
    test "#can_handle_assigned?", context do
      assert Order.can_handle_assigned?(context[:created_order]) == true
      assert Order.can_handle_assigned?(context[:assigned_order]) == false
      assert Order.can_handle_assigned?(context[:finished_order]) == false
      assert Order.can_handle_assigned?(context[:closed_order]) == false
    end

    test "#can_handle_finished?", context do
      assert Order.can_handle_finished?(context[:created_order]) == false
      assert Order.can_handle_finished?(context[:assigned_order]) == true
      assert Order.can_handle_finished?(context[:finished_order]) == false
      assert Order.can_handle_assigned?(context[:closed_order]) == false
    end

    test "#can_handle_closed?", context do
      assert Order.can_handle_closed?(context[:created_order]) == true
      assert Order.can_handle_closed?(context[:assigned_order]) == true
      assert Order.can_handle_closed?(context[:finished_order]) == true
      assert Order.can_handle_assigned?(context[:closed_order]) == false
    end
  end
end
