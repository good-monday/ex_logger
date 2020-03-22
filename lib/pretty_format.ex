defmodule ExLogger.PrettyFormat do
  def format(level, message, timestamp, metadata) do
    "#{fmt_timestamp(timestamp)} [#{level |> fmt_level}]#{fmt_metadata(metadata)} #{message}\n"

    rescue
      _ -> "could not format message: #{inspect({level, message, timestamp, metadata})}\n"
  end

  defp fmt_metadata(md) do
    md
    |> Keyword.keys()
    |> Enum.sort()
    |> Enum.map(&(output_metadata(md, &1)))
    |> Enum.join()
  end

  def output_metadata(metadata, key) do
    case key do
      :request_id -> cyan(" [##{metadata[key]}]")
      :user_id -> light_cyan(" [#{metadata[key]}]")
    end
  end

  defp fmt_timestamp({date, {hh, mm, ss, ms}}) do
    with {:ok, timestamp} <- NaiveDateTime.from_erl({date, {hh, mm, ss}}, {ms * 1000, 3}),
      result <- NaiveDateTime.to_iso8601(timestamp)
    do
      "#{result}Z"
    end
  end

  defp fmt_level(level) do
    case level |> Atom.to_string() |> String.upcase() do
      "INFO" -> green("INFO ")
      #"WARN" -> yellow("WARN") # already coloured by default
      #"ERROR" -> red("ERROR")  # already coloured by default
      other ->
        String.pad_trailing(other, 5) # Ensure level padding
    end
  end

  defp green(text) do
    IO.ANSI.green() <> text <> IO.ANSI.reset()
  end

  defp cyan(text) do
    IO.ANSI.cyan() <> text <> IO.ANSI.reset()
  end

  defp light_cyan(text) do
    IO.ANSI.light_cyan() <> text <> IO.ANSI.reset()
  end
end
