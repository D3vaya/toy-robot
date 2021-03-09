defmodule ToyRobot.Game.Player do
  use GenServer

  alias ToyRobot.{Robot}

  # def start_link(table: table, position: position, name: name) do
  #   GenServer.start_link(__MODULE__, [table: table, position: position], name: process_name(name))
  # end

  def start(position) do
    GenServer.start(__MODULE__, position)
  end

  def init(robot) do
    {:ok, robot}
  end

  # # sincrono
  def handle_call(:report, _from, robot) do
    {:reply, robot, robot}
  end

  def handle_cast(:move, robot) do
    {:noreply, robot |> Robot.move()}
  end

  # def process_name(name) do
  #   {:via, Registry, {ToyRobot.Game.PlayerRegistry, name}}
  # end

  def report(player) do
    GenServer.call(player, :report)
  end

  def move(player) do
    GenServer.cast(player, :move)
  end

  # asyncrono
  # def handle_cast(:move, simulation) do
  #   {:ok, new_simulation} = simulation |> Simulation.move()
  #   {:noreply, new_simulation}
  # end
end
