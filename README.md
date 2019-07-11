# Artikel

Artikel is a Phoenix application which uses Elevio API

## Requirements
  * Elixir
  * Phoenix

## Installation
  * `git clone https://github.com/hiorws/artikel.git`
  * `cd artikel`
  * Set env variable `SECRET_KEY_BASE`
  * Copy the `config/dev.secret.sample.exs` file to `config/dev.secret.exs` and edit the `api_key` and `api_token`
  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Endpoints
  * `/articles`
  * `/article/:id`
  * `/search/:keyword`
