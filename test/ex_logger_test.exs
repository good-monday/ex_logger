defmodule ExLoggerTest do
  use ExUnit.Case

  @timestamp {{2020, 1, 1}, { 0, 0, 0, 0}}

  test "Allow empty metadata" do
    assert ExLogger.PrettyFormat.format(:info, "hello world", @timestamp, []) ==
      "2020-01-01T00:00:00.000Z [\e[32mINFO \e[0m] hello world\n"
  end

  test "With user id" do
    assert ExLogger.PrettyFormat.format(:info, "hello world", @timestamp, [user_id: "qwerty123"]) ==
      "2020-01-01T00:00:00.000Z [\e[32mINFO \e[0m]\e[96m [qwerty123]\e[0m hello world\n"
  end

  test "With request id" do
    assert ExLogger.PrettyFormat.format(:info, "hello world", @timestamp, [user_id: "qwerty123", request_id: "abc123456789"]) ==
      "2020-01-01T00:00:00.000Z [\e[32mINFO \e[0m]\e[36m [#abc123456789]\e[0m\e[96m [qwerty123]\e[0m hello world\n"
  end

  test "Warnings" do
    assert ExLogger.PrettyFormat.format(:warn, "hello world", @timestamp, [user_id: "qwerty123", request_id: "abc123456789"]) ==
      "2020-01-01T00:00:00.000Z [WARN ]\e[36m [#abc123456789]\e[0m\e[96m [qwerty123]\e[0m hello world\n"
  end

  test "Errors" do
    assert ExLogger.PrettyFormat.format(:error, "hello world", @timestamp, [user_id: "qwerty123", request_id: "abc123456789"]) ==
      "2020-01-01T00:00:00.000Z [ERROR]\e[36m [#abc123456789]\e[0m\e[96m [qwerty123]\e[0m hello world\n"
  end
end
