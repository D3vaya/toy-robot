defmodule ToyRobot.Game.Players do
  alias ToyRobot.Game.Player

  def all(registry_id) do
    registry_id
    |> Registry.select([{{:"$1", :_, :_}, [], [:"$1"]}])
    |> Enum.map(fn {player_name} -> Player.process_name(registry_id, player_name) end)
  end

  def positions(players) do
    players |> Enum.map(&(&1 |> Player.report() |> coordinates))
  end

  def position_available?(occuped_positions, position) do
    (position |> coordinates()) not in occuped_positions
  end

  defp coordinates(position) do
    position |> Map.take({:north, :east})
  end
end
