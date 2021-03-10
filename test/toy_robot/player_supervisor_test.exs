defmodule ToyRobot.Game.PlayerSupervisorTest do
  use ExUnit.Case, async: true

  alias ToyRobot.{Table, Game.PlayerSupervisor}

  setup do
    registry_id = "play-sup-test-#{UUID.uuid4()}" |> String.to_atom()
    Registry.start_link(keys: :unique, name: registry_id)
    starting_position = %{north: 0, east: 0, facing: :north}
    player_name = "Izzy"

    {:ok, _player} =
      PlayerSupervisor.start_child(
        registry_id,
        build_table(),
        starting_position,
        player_name
      )

    [{_registered_player, _}] =
      Registry.lookup(
        registry_id,
        player_name
      )

    {:ok, %{registry_id: registry_id, player_name: player_name}}
  end

  def build_table do
    %Table{
      east_boundary: 4,
      north_boundary: 4
    }
  end

  # test "Iniciar proceso player hijo", %{
  #   registry_id: registry_id,
  #   starting_position: starting_position
  # } do
  #   {:ok, player} =
  #     PlayerSupervisor.start_child(registry_id, build_table(), starting_position, "Izzy")

  #   [{registered_player, _}] = Registry.lookup(ToyRobot.Game.PlayerRegistry, "Izzy")
  #   assert registered_player == player
  # end

  test "Mueve un robot hacia adelante", %{
    registry_id: registry_id,
    player_name: player_name
  } do
    :ok = PlayerSupervisor.move(registry_id, player_name)
    # la asignacion de mapas es como destructuracion en Js
    %{north: north} = PlayerSupervisor.report(registry_id, player_name) |> IO.inspect()
    assert north == 1
  end

  test "Reporte de la localización del robot", %{
    registry_id: registry_id,
    player_name: player_name
  } do
    %{north: north} = PlayerSupervisor.report(registry_id, player_name)
    assert north == 0
  end
end
