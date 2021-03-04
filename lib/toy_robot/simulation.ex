defmodule ToyRobot.Simulation do
  defstruct [:table, :robot]
  alias ToyRobot.{Robot, Simulation, Table}

  @doc """
  Simular la posicion del robot en la mesa

  ## Ejemplos

  Cuando el robot se coloca en una posición válida

  iex> alias ToyRobot.{Robot, Table, Simulation}
  [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
  iex> table = %Table{north_boundary: 4, east_boundary: 4}
  %Table{north_boundary: 4, east_boundary: 4}
  iex> Simulation.place(table, %{north: 0, east: 0, facing: :north})
  {
    :ok,
    %Simulation{
      table: table,
      robot: %Robot{north: 0, east: 0, facing: :north}
    }
  }

  cuando el robot es colocado en una posicion invalida:

  iex> alias ToyRobot.{Table, Simulation}
  [ToyRobot.Table, ToyRobot.Simulation]
  iex> table = %Table{north_boundary: 4, east_boundary: 4}
  %Table{north_boundary: 4, east_boundary: 4}
  iex> Simulation.place(table, %{north: 6, east: 0, facing: :north})
  {:error, :invalid_placement}
  """

  def place(table, placement) do
    if table |> Table.valid_position?(placement) do
      {
        :ok,
        %__MODULE__{
          table: table,
          robot: struct(Robot, placement)
        }
      }
    else
      {:error, :invalid_placement}
    end
  end
end
