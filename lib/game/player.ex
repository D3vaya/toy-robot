defmodule ToyRobot.Game.Player do
  use GenServer

  alias ToyRobot.{Simulation, Table}

  def start_link(robot) do
    GenServer.start_link(__MODULE__, robot)
  end

  def start(position) do
    GenServer.start(__MODULE__, position)
  end

  def init(robot) do
    simulation = %Simulation{
      table: %Table{
        north_boundary: 4,
        east_boundary: 4
      },
      robot: robot
    }

    {:ok, simulation}
  end

  def report(player) do
    GenServer.call(player, :report)
  end

  def move(player) do
    GenServer.cast(player, :move)
  end

  # sincrono
  def handle_call(:report, _from, simulation) do
    {:reply, simulation |> Simulation.report(), simulation}
  end

  # asyncrono
  def handle_cast(:move, simulation) do
    {:ok, new_simulation} = simulation |> Simulation.move()
    {:noreply, new_simulation}
  end
end
