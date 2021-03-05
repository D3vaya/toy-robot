defmodule ToyRobot.CommandRunnerTest do
  use ExUnit.Case, async: true
  alias ToyRobot.{CommandRunner, Simulation}
  import ExUnit.CaptureIO

  test "Manejar comando PLACE valido" do
    %Simulation{robot: robot} =
      CommandRunner.run([{:place, %{east: 1, north: 2, facing: :north}}])

    assert robot.east == 1
    assert robot.north == 2
    assert robot.facing == :north
  end

  test "Manejar comando PLACE invalido" do
    simulation = CommandRunner.run([{:place, %{east: 10, north: 10, facing: :north}}])
    assert simulation == nil
  end

  test "Ignorar comandos hasta que tengamos un PLACE valido " do
    %Simulation{robot: robot} =
      [
        :move,
        {:place, %{east: 1, north: 2, facing: :north}}
      ]
      |> CommandRunner.run()

    assert robot.east == 1
    assert robot.north == 2
    assert robot.facing == :north
  end

  test "Manejar comando PLACE + comando MOVE" do
    %Simulation{robot: robot} =
      [
        {:place, %{east: 1, north: 2, facing: :north}},
        :move
      ]
      |> CommandRunner.run()

    assert robot.east == 1
    assert robot.north == 3
    assert robot.facing == :north
  end

  test "Manejar comando PLACE + comando MOVE invalido" do
    %Simulation{robot: robot} =
      [
        {:place, %{east: 1, north: 4, facing: :north}},
        :move
      ]
      |> CommandRunner.run()

    assert robot.east == 1
    assert robot.north == 4
    assert robot.facing == :north
  end

  test "Manejar comando PLACE + comando LEFT" do
    %Simulation{robot: robot} =
      [
        {:place, %{east: 1, north: 2, facing: :north}},
        :turn_left
      ]
      |> CommandRunner.run()

    assert robot.east == 1
    assert robot.north == 2
    assert robot.facing == :west
  end

  test "Manejar comando PLACE + comando RIGHT" do
    %Simulation{robot: robot} =
      [
        {:place, %{east: 1, north: 2, facing: :north}},
        :turn_right
      ]
      |> CommandRunner.run()

    assert robot.east == 1
    assert robot.north == 2
    assert robot.facing == :east
  end

  test "Manejar comando PLACE + comando REPORT" do
    commands = [
      {:place, %{east: 1, north: 2, facing: :north}},
      :report
    ]

    output = capture_io(fn -> CommandRunner.run(commands) end)
    assert output |> String.trim() == "The robot is at (1,2) and is facing NORTH"
  end

  test "Manejar comando PLACE + commando invalido" do
    %Simulation{robot: robot} =
      [
        {:place, %{east: 1, north: 2, facing: :north}},
        {:invalid, "EXTERMINATE"}
      ]
      |> CommandRunner.run()

    assert robot.east == 1
    assert robot.north == 2
    assert robot.facing == :north
  end

  test "El robot no puede moverse más allá del límite norte" do
    %Simulation{robot: robot} =
      [
        {:place, %{east: 0, north: 4, facing: :north}},
        :move
      ]
      |> CommandRunner.run()

    assert robot.north == 4
  end

  test "El robot no puede moverse más allá del límite este" do
    %Simulation{robot: robot} =
      [
        {:place, %{east: 4, north: 0, facing: :east}},
        :move
      ]
      |> CommandRunner.run()

    assert robot.east == 4
  end

  test "El robot no puede moverse más allá del límite sur" do
    %Simulation{robot: robot} =
      [
        {:place, %{east: 0, north: 0, facing: :south}},
        :move
      ]
      |> CommandRunner.run()

    assert robot.north == 0
  end

  test "El robot no puede moverse más allá del límite oeste" do
    %Simulation{robot: robot} =
      [
        {:place, %{east: 0, north: 0, facing: :west}},
        :move
      ]
      |> CommandRunner.run()

    assert robot.east == 0
  end
end
