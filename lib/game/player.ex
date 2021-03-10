defmodule ToyRobot.Game.Player do
  use GenServer

  alias ToyRobot.{Simulation, Robot}

  def start_link(table: table, position: position, name: name) do
    GenServer.start_link(__MODULE__, [table: table, position: position], name: process_name(name))
  end

  def start(table, position) do
    GenServer.start(__MODULE__, table: table, position: position)
  end

  def init(table: table, position: position) do
    simulation = %Simulation{
      table: table,
      robot: struct!(Robot, position)
    }

    {:ok, simulation}
  end

  # # sincrono
  def handle_call(:report, _from, simulation) do
    {:reply, simulation |> Simulation.report(), simulation}
  end

  # asyncrono
  def handle_cast(:move, simulation) do
    {:ok, new_simulation} = simulation |> Simulation.move()
    {:noreply, new_simulation}
  end

  def move(player) do
    GenServer.cast(player, :move)
  end

  def report(player) do
    GenServer.call(player, :report)
  end

  def process_name(name) do
    {:via, Registry, {ToyRobot.Game.PlayerRegistry, name}}
  end
end
