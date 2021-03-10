defmodule ToyRobot.Game.PlayerTest do
  use ExUnit.Case, async: true

  alias ToyRobot.Game.Player
  alias ToyRobot.{Robot, Table}

  def build_table do
    %Table{east_boundary: 4, north_boundary: 4}
  end

  describe "Command Report |> " do
    setup do
      starting_position = %{north: 0, east: 0, facing: :north}
      {:ok, player} = Player.start(build_table(), starting_position)
      %{player: player}
    end

    test "Muestra la posición actual del robot", %{player: player} do
      assert Player.report(player) == %Robot{
               north: 0,
               east: 0,
               facing: :north
             }
    end
  end

  describe "Command Move" do
    setup do
      starting_position = %{north: 0, east: 0, facing: :north}
      {:ok, player} = Player.start(build_table(), starting_position)
      %{player: player}
    end

    test "Mueve el robot hacia delante 1 espacio", %{player: player} do
      # %{robot: robot} = Player.move(player)
      :ok = Player.move(player)

      assert Player.report(player) == %Robot{
               north: 1,
               east: 0,
               facing: :north
             }
    end
  end
end
