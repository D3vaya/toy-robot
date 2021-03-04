defmodule ToyRobot.CommandInterpreterTest do
  use ExUnit.Case
  doctest ToyRobot.CommandInterpreter

  alias ToyRobot.CommandInterpreter

  test "Manejar los comandos" do
    commands = ["PLACE 1,2, NORTH", "MOVE", "LEFT", "REPORT"]
    commands |> CommandInterpreter.interpret()
  end

  test "Marca los comandos inválidos como inválidos" do
    commands = ["SPIN", "TWIRL", "EXTERMINATE"]
    output = commands |> CommandInterpreter.interpret()

    assert output == [
             {:invalid, "SPIN"},
             {:invalid, "TWIRL"},
             {:invalid, "EXTERMINATE"}
           ]
  end
end
