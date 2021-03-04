defmodule ToyRobot.RobotTest do
  use ExUnit.Case
  doctest ToyRobot.Robot
  alias ToyRobot.Robot

  describe "cuando el robot apunta al norte" do
    setup do
      {:ok, %{robot: %Robot{north: 0, facing: :north}}}
    end

    test "mover 1 espacio al norte", %{robot: robot} do
      robot = robot |> Robot.move()
      assert robot.north == 1
    end

    test "gira a la izquiera para mirar el oeste", %{robot: robot} do
      robot = robot |> Robot.turn_left()
      assert robot.facing == :west
    end

    test "gira a la derecha para mirar el este", %{robot: robot} do
      robot = robot |> Robot.turn_right()
      assert robot.facing == :east
    end
  end

  describe "cuando el robot apunta al norte y se ha movido hacia adelante un espacio" do
    setup do
      {:ok, %{robot: %Robot{north: 1, facing: :north}}}
    end

    test "gira a la derecha para mirar al este", %{robot: robot} do
      robot = robot |> Robot.turn_right()
      assert robot.facing == :east
      assert robot.north == 1
    end

    test "gira a la izquierda para mirar al oeste", %{robot: robot} do
      robot = robot |> Robot.turn_left()
      assert robot.facing == :west
      assert robot.north == 1
    end
  end

  describe "cuando el robot apunta al norte y se ha movido hacia el este un espacio" do
    setup do
      {:ok, %{robot: %Robot{east: 1, facing: :north}}}
    end

    test "mover un espacio al norte", %{robot: robot} do
      robot = robot |> Robot.move()
      assert robot.north == 1
      assert robot.east == 1
      assert robot.facing == :north
    end
  end

  describe "cuando el robot apunta al este" do
    setup do
      {:ok, %{robot: %Robot{east: 0, facing: :east}}}
    end

    test "mover un espacio al este", %{robot: robot} do
      robot = robot |> Robot.move()
      assert robot.east == 1
    end

    test "gira a la izquierda para mirar el norte", %{robot: robot} do
      robot = robot |> Robot.turn_left()
      assert robot.facing == :north
    end

    test "gira a la derecha para mirar el sur", %{robot: robot} do
      robot = robot |> Robot.turn_right()
      assert robot.facing == :south
    end
  end

  describe "cuando el robot apunta al este y se ha movido hacia el norte un espacio" do
    setup do
      {:ok, %{robot: %Robot{north: 1, facing: :east}}}
    end

    test "mover un espacio al este", %{robot: robot} do
      robot = robot |> Robot.move()
      assert robot.north == 1
      assert robot.east == 1
      assert robot.facing == :east
    end
  end

  describe "cuando el robot apunta al sur," do
    setup do
      {:ok, %{robot: %Robot{north: 0, facing: :south}}}
    end

    test "mover un espacio al sur", %{robot: robot} do
      robot = robot |> Robot.move()
      assert robot.north == -1
    end

    test "gira a la izquierda para mirar el este", %{robot: robot} do
      robot = robot |> Robot.turn_left()
      assert robot.facing == :east
    end

    test "gira a la derecha para mirar el oeste", %{robot: robot} do
      robot = robot |> Robot.turn_right()
      assert robot.facing == :west
    end
  end

  describe "cuando el robot apunta al sur y se ha movido hacia el este un este" do
    setup do
      {:ok, %{robot: %Robot{east: 1, facing: :south}}}
    end

    test "mover un espacio al sur", %{robot: robot} do
      robot = robot |> Robot.move()
      assert robot.north == -1
      assert robot.east == 1
      assert robot.facing == :south
    end
  end

  describe "cuando el robot apunta al oeste," do
    setup do
      {:ok, %{robot: %Robot{east: 0, facing: :west}}}
    end

    test "mover un espacio al oeste", %{robot: robot} do
      robot = robot |> Robot.move()
      assert robot.east == -1
    end

    test "gira a la izquierda para mirar el sur", %{robot: robot} do
      robot = robot |> Robot.turn_left()
      assert robot.facing == :south
    end

    test "gira a la derecha para mirar el norte", %{robot: robot} do
      robot = robot |> Robot.turn_right()
      assert robot.facing == :north
    end
  end

  describe "cuando el robot apunta al oeste y se ha movido hacia el norte un espacio" do
    setup do
      {:ok, %{robot: %Robot{north: 1, facing: :west}}}
    end

    test "mover un espacio al oeste", %{robot: robot} do
      robot = robot |> Robot.move()
      assert robot.north == 1
      assert robot.east == -1
      assert robot.facing == :west
    end
  end
end
