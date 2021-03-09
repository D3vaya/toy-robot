# defmodule ToyRobot.Game.PlayerSupervisorTest do
#   use ExUnit.Case, async: true

#   alias ToyRobot.{Game.PlayerSupervisor, Table}

#   # setup do
#   #   {:ok, sup} = PlayerSupervisor.start_link([])
#   #   {:ok, %{sup: sup}}
#   # end

#   # test "Iniciar proceso player hijo" do
#   #   robot = %Robot{north: 0, east: 0, facing: :north}
#   #   {:ok, _player} = PlayerSupervisor.start_child(robot, "Jc2")
#   #   %{active: active} = DynamicSupervisor.count_children(PlayerSupervisor)
#   #   assert active == 1
#   # end
#   def build_table do
#     %Table{
#       east_boundary: 4,
#       north_boundary: 4
#     }
#   end

#   test "Iniciar registro" do
#     registry = Process.whereis(ToyRobot.Game.PlayerRegistry)
#     assert registry
#   end

#   test "inicia un proceso hijo del juego" do
#     starting_position = %{north: 0, east: 0, facing: :north}
#     {:ok, player} = PlayerSupervisor.start_child(build_table(), starting_position, "Izzy")
#     [{pid_registered_player, _}] = Registry.lookup(ToyRobot.Game.PlayerRegistry, "Izzy")
#     assert pid_registered_player == player
#   end

#   test "Mueve un robot hacia adelante" do
#     starting_position = %{north: 0, east: 0, facing: :north}
#     {:ok, _player} = PlayerSupervisor.start_child(build_table(), starting_position, "Charlie")

#     :ok = PlayerSupervisor.move("Charlie")
#     %{north: north} = PlayerSupervisor.report("Charlie")

#     assert north == 1
#   end

#   test "Generar reporte del robot" do
#     starting_position = %{north: 0, east: 0, facing: :north}
#     {:ok, _player} = PlayerSupervisor.start_child(build_table(), starting_position, "Davros")
#     %{north: north} = PlayerSupervisor.report("Davros")
#     assert north == 0
#   end
# end
