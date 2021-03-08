defmodule ToyRobot.Game.PlayerTest do
  use ExUnit.Case, async: true

  alias ToyRobot.Game.Player
  alias ToyRobot.Robot

  describe "report" do
    setup do
      starting_position = %Robot{north: 0, east: 0, facing: :north}
      {:ok, player} = Player.start(starting_position)
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

  describe "Move" do
    setup do
      starting_position = %Robot{north: 0, east: 0, facing: :north}
      {:ok, player} = Player.start(starting_position)
      %{player: player}
    end

    test "Muestra la posición actual del robot despues del comando MOVE", %{player: player} do
      :ok = Player.move(player)

      assert Player.report(player) == %Robot{
               north: 1,
               east: 0,
               facing: :north
             }
    end
  end
end
