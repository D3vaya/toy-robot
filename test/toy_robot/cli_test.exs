defmodule ToyRobot.CliTest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO

  test "Proporciona instrucciones de uso si no se especifican argumentos" do
    output = capture_io(fn -> ToyRobot.CLI.main([]) end)
    assert output |> String.trim() == "Usage: toy_robot commands.txt"
  end

  test "Proporciona instrucciones de uso si se especifican demasiados argumentos" do
    output = capture_io(fn -> ToyRobot.CLI.main(["commands.text", "commands2.txt"]) end)
    assert output |> String.trim() == "Usage: toy_robot commands.txt"
  end

  test "Mostrar los errores si el archivo de comandos no existe" do
    output = capture_io(fn -> ToyRobot.CLI.main(["i-do-not-exist.txt"]) end)
    assert output |> String.trim() == "The file i-do-not-exist.txt does not exist"
  end

  test "Manejar que los comandos y el reporte funcionen correctamente" do
    commands_path = Path.expand("test/fixtures/commands.txt", File.cwd!())
    output = capture_io(fn -> ToyRobot.CLI.main([commands_path]) end)

    expected_output = """
    The robot is at (0,4) and is facing NORTH
    """

    assert output |> String.trim() == expected_output |> String.trim()
  end
end
