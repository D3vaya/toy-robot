defmodule ToyRobot.Game.PlayerSupervisorTest do
  use ExUnit.Case, async: true

  alias ToyRobot.{Game.PlayerSupervisor, Robot}

  setup do
    {:ok, sup} = PlayerSupervisor.start_link([])
    {:ok, %{sup: sup}}
  end

  test "Iniciar proceso player hijo", %{sup: sup} do
    robot = %Robot{north: 0, east: 0, facing: :north}
    {:ok, _player} = PlayerSupervisor.start_child(sup, robot)
    %{active: active} = DynamicSupervisor.count_children(sup)
    assert active == 1
  end
end
