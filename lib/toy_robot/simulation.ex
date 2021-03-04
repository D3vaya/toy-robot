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

  @doc """
  Moves the robot forward one space in the direction that it is facing, unless that position is past the bou\
  ndaries of the table.

  ## Ejemplos

  ### Movimiento valido
  iex> alias ToyRobot.{Robot, Table, Simulation}
  [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
  iex> table = %Table{north_boundary: 4, east_boundary: 4}
  %Table{north_boundary: 4, east_boundary: 4}
  iex> simulation = %Simulation{
  ...>  table: table,
  ...>  robot: %Robot{north: 0, east: 0, facing: :north}
  ...> }
  iex> simulation |> Simulation.move
  {:ok, %Simulation{
    table: table,
    robot: %Robot{north: 1, east: 0, facing: :north}
  }}

  ### Movimiento invalido:

  iex> alias ToyRobot.{Robot, Table, Simulation}
  [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
  iex> table = %Table{north_boundary: 4, east_boundary: 4}
  %Table{north_boundary: 4, east_boundary: 4}
  iex> simulation = %Simulation{
  ...>  table: table,
  ...>  robot: %Robot{north: 4, east: 0, facing: :north}
  ...> }
  iex> simulation |> Simulation.move()
  {:error, :at_table_boundary}

  """
  def move(%Simulation{robot: robot, table: table} = simulation) do
    with moved_robot <- robot |> Robot.move(),
         true <- table |> Table.valid_position?(moved_robot) do
      {:ok, %{simulation | robot: moved_robot}}
    else
      false -> {:error, :at_table_boundary}
    end
  end

  @doc """
  Girar el robot a la izquierda
  ## Eejmplos
  iex> alias ToyRobot.{Robot, Table, Simulation}
  [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
  iex> table = %Table{north_boundary: 4, east_boundary: 4}
  %Table{north_boundary: 4, east_boundary: 4}
  iex> simulation = %Simulation{
  ...> table: table,
  ...> robot: %Robot{north: 0, east: 0, facing: :north}
  ...>}
  iex> simulation |> Simulation.turn_left
  {:ok, %Simulation{
    table: table,
    robot: %Robot{north: 0, east: 0, facing: :west}
  }}
  """
  def turn_left(%Simulation{robot: robot} = simulation) do
    {:ok, %{simulation | robot: robot |> Robot.turn_left()}}
  end

  @doc """
  Girar el robot a la derecha
  ## Eejmplos
  iex> alias ToyRobot.{Robot, Table, Simulation}
  [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
  iex> table = %Table{north_boundary: 4, east_boundary: 4}
  %Table{north_boundary: 4, east_boundary: 4}
  iex> simulation = %Simulation{
  ...> table: table,
  ...> robot: %Robot{north: 0, east: 0, facing: :north}
  ...>}
  iex> simulation |> Simulation.turn_right
  {:ok, %Simulation{
    table: table,
    robot: %Robot{north: 0, east: 0, facing: :east}
  }}
  """
  def turn_right(%Simulation{robot: robot} = simulation) do
    {:ok, %{simulation | robot: robot |> Robot.turn_right()}}
  end

  @doc """
  Retorna la posicion actual del robot
  ## Ejemplos

  iex> alias ToyRobot.{Robot, Table, Simulation}
  [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
  iex> table = %Table{north_boundary: 4, east_boundary: 4}
  %Table{north_boundary: 4, east_boundary: 4}
  iex> simulation = %Simulation{
  ...> table: table,
  ...> robot: %Robot{north: 0, east: 0, facing: :north}
  ...>}
  iex> simulation |> Simulation.report
  %Robot{north: 0, east: 0, facing: :north}
  """

  def report(%Simulation{robot: robot}), do: robot
end
