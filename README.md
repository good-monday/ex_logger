# ExLogger

Provides a custom log formatter

## Installation

The package can be installed
by adding `ex_logger` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_logger, git: "https://github.com/good-monday/ex_logger.git", tag: "0.1.0"}
  ]
end
```

## Configuration

Configure JwtAuth in your config file

```elixir
config :logger, :console,
  format: {ExLogger.PrettyFormat, :format},
  level: :info,
  metadata: [:request_id, :user_id]
```

## Usage

JwtAuth is now available to be used as a Plug

```elixir
plug JwtAuth
```
