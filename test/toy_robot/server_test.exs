defmodule ToyRobot.Game.ServerTest do
  use ExUnit.Case, async: true
  alias ToyRobot.Game.Server

  setup do
    {:ok, game} = Server.start_link(north_boundary: 4, east_boundary: 4)
    {:ok, %{game: game}}
  end

  test "Poder ingresar un player", %{game: game} do
    :ok = Server.place(game, %{north: 0, east: 0, facing: :north}, "Rosie")
    assert Server.player_count(game) == 1
  end

  test "No se puede poner un robot fuera de los límites", %{game: game} do
    assert Server.place(
             game,
             %{north: 10, east: 10, facing: :north},
             "Eve"
           ) == {:error, :out_of_bounds}
  end

  test "No colocar un robot en el mismo espacio que otro robot", %{game: game} do
    starting_position = %{north: 0, east: 0, facing: :north}

    :ok =
      Server.place(
        game,
        starting_position,
        "Wall-E"
      )

    assert Server.place(
             game,
             starting_position,
             "Robby"
           ) == {:error, :occuped}
  end
end
