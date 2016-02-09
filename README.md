# skroutz.ex

A minimalistic Skroutz API client, for Elixir

## Installation

Hex package coming up soon.

When [available in Hex](https://hex.pm/docs/publish), to install the package:

  1. Add skroutzex to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:skroutzex, "~> version_here"}]
end
```

  2. Ensure skroutzex is started before your application:

```elixir
def application do
  [applications: [:skroutzex]]
end
```

## Resources

- [Category](http://developer.skroutz.gr/api/v3/category/)
- [Sku](http://developer.skroutz.gr/api/v3/sku/)
- [Product](http://developer.skroutz.gr/api/v3/product/)
- [Shop](http://developer.skroutz.gr/api/v3/shop/)
- [Manufacturer](http://developer.skroutz.gr/api/v3/manufacturer/)

## Usage

### Create a client process

```elixir
# With OAuth2.0 credentials
{:ok, skroutz} = Skroutzex.new(%{client_id: "id", client_secret: "secret"})

# With OAuth2.0 credentials, for the Alve flavor
{:ok, alve} = Skroutzex.new(%{client_id: "id",
                              client_secret: "secret",
                              flavor: :alve})
```

```elixir
# With existing Oauth2.0 access token
{:ok, skroutz} = Skroutzex.new("a valid access token")
```

### Search

```elixir
{:ok, skroutz} = Skroutzex.new("a valid token")

skroutz |> Skroutzex.Search.search("nexus 6")
```

## Examples

> Reminder: You can use Module.module_info(:exports) to get a list of
> functions available on a module.
> Then you can use `h` inside `iex` to print documentation.

```elixir
h Skroutzex.Category.find

# Prints documentation for the function
```

### Categories

```elixir
{:ok, skroutz} = Skroutzex.new("a valid token")

# Get a specific category
skroutz |> Skroutzex.Category.find(40)
```

## Compatibility

The project has been tested to work with elixir version 1.2.
It may inadvertently work (or seem to work) with other versions, however compatibility and support are not guaranteed.

## Development

### Running the tests

```shell
mix test
```

### Console

```shell
iex -S mix
```

### OAuth2.0 Credentials

In order for the client to make requests against our API,
a valid set of OAuth2.0 credentials provided by us has to be used.
To get yours send an email at [api@skroutz.gr](mailto: api@skroutz.gr).

# LICENSE

Copyright (c) 2016 Dimitris Zorbas, MIT Licence.
See [LICENSE.txt](https://github.com/skroutz/skroutzex/blob/master/LICENSE.txt) for further details.
