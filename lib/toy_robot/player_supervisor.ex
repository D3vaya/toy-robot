defmodule ToyRobot.Game.PlayerSupervisor do
  use DynamicSupervisor
  alias ToyRobot.Game.Player

  def start_link(args) do
    DynamicSupervisor.start_link(__MODULE__, args)
  end

  def init(_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_child(sup, robot) do
    DynamicSupervisor.start_child(sup, {Player, robot})
  end
end
