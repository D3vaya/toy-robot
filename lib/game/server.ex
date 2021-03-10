# defmodule ToyRobot.Game.Server do
#   use GenServer

#   alias ToyRobot.Table
#   alias ToyRobot.Game.PlayerSupervisor

#   def start_link(args) do
#     GenServer.start_link(__MODULE__, args)
#   end

#   def init(north_boundary: north_boundary, east_boundary: east_boundary) do
#     {:ok,
#      %{
#        table: %Table{
#          east_boundary: east_boundary,
#          north_boundary: north_boundary
#        }
#      }}
#   end

#   @spec place(atom | pid | {atom, any} | {:via, atom, any}, any, any) :: any
#   def place(game, position, name) do
#     GenServer.call(game, {:place, position, name})
#   end

#   def handle_call({:place, position, name}, _from, %{table: table, players: players} = state) do
#     {:ok, player} = PlayerSupervisor.start_child(table, position, name)
#     players = players |> Map.put(name, player)
#     {:reply, :ok, %{state | players: players}}
#   end

#   def player_count(game) do
#     GenServer.call(game, :player_count)
#   end
# end
