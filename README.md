# MeatBar

*Meat Bar Consumption Analytics*

Simple REST-like service to tracking and analyzing [Meat Bar](http://)
consumption by registered users.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `meat_bar` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:meat_bar, "~> 0.1.0"}]
    end
    ```

  2. Ensure `meat_bar` is started before your application:

    ```elixir
    def application do
      [applications: [:meat_bar]]
    end
    ```

## API

The following endpoints are supported.

### GET `/people`

Returns a list of all registered Meat Bar consumers.

Example:
```
curl http://127.0.0.1:8282/people

[ "ashton", "bob", "chuck" ]
```

### GET `/consumption`

Returns a list of all known Meat Bar consumption.

Example:
```
curl http://127.0.0.1:8282/consumption

[ { "person": "ashton", "type": "beef", "date": "2015-01-01T01:00:00.000Z" }
, { "person": "bob", "type": "lamb", "date": "2015-01-01T08:00:00.000Z" }
]
```

### POST `/consumption`

Record a new Meat Bar consumption.

Example:
```
curl -H "Content-Type: application/json" -X POST -d '{ "person": "chuck", "type": "bison", "date": "2015-05-01T06:00:00.000Z" }' http://127.0.0.1:8282/consumption
```

### GET `/reports/streaks`

Generate a report of all streaks of days (allowing for days off) when more and
more meat bars were consumed. A streak is defined a three or more days where the
total number of bars consumed increased. TODO: Confirm this definition.

Example:
```
curl http://127.0.0.1:8282/reports/streaks

TODO: Paste example after route is implemented.
```

### GET `/reports/monthly_peaks`

Generate a report of month peak consumption dates. For each month, this is the
day of the month when consumption by all people was at its highest.

Example:
```
curl http://127.0.0.1:8282/reports/monthly_peaks

TODO: Paste example after route is implemented.
```
