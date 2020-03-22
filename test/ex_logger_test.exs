defmodule ExLoggerTest do
  use ExUnit.Case
  doctest ExLogger

  test "greets the world" do
    assert ExLogger.hello() == :world
  end
end
