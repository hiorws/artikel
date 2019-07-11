defmodule Artikel.Client do

  @key Application.get_env(:artikel, :api_key)
  @token Application.get_env(:artikel, :api_token)
  @base_url "https://api.elevio-staging.com/v1"

  def get_articles() do
    endpoint = @base_url <> "/articles"
    headers = ["Authorization": "Bearer #{@token}", "x-api-key": @key]
    case HTTPoison.get(endpoint, headers) do
      {:ok, %{body: raw_body, status_code: code}} ->
        {code, raw_body}
      {:error, %{reason: reason}} ->
        {:error, reason}
    end
    |> (fn {ok, body} ->
      body
      |> Poison.decode(keys: :atoms)
      |> case do
        {:ok, parsed} ->
          {ok, parsed}
        _ ->
          {:error, body}
      end
    end).()
    |> (fn {200, articles_map} ->
      articles_map.articles
    end).()
  end

  def get_article(article_id) do
    endpoint = @base_url <> "/articles/" <> to_string(article_id)
    headers = ["Authorization": "Bearer #{@token}", "x-api-key": @key]
    case HTTPoison.get(endpoint, headers) do
      {:ok, %{body: raw_body, status_code: code}} -> {code, raw_body}
      {:error, %{reason: reason}} -> {:error, reason}
    end
    |> (fn {ok, body} ->
      body
      |> Poison.decode(keys: :atoms)
      |> case do
        {:ok, parsed} -> {ok, parsed}
        _ -> {:error, body}
      end
    end).()
    |> (fn {200, article} ->
      article.article
    end).()
  end

  def search_articles(keyword) do
    # key = "fa2908ab88365df241f3a80a972ccd4c"
    # token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FwcC5lbGV2aW8tc3RhZ2luZy5jb20iLCJzdWIiOiI1ZDFkYjgzMWI2YzRkIiwiZXhwIjozMTM5MDM1OTgwLCJpYXQiOjE1NjIyMzU5ODAsImp0aSI6InFvN25rZ2Q5Z2xrZzNmNXVhZzkxYnRqbHJwYzFnNWFuIiwKICAidXNlck5hbWUiIDogIm96Z3VyZmlyYXRjaW5hckBnbWFpbC5jb20iLAogICJ1c2VySWQiIDogMTMwNTUsCiAgInNjb3BlIiA6IFsgInJlYWQ6YXJ0aWNsZSIgXQp9.5rjSxm66tz9W_lho1wHoeH4osMlDHYwzY0dnTbnUUfU"
    endpoint = @base_url <> "/search/en?query=" <> keyword
    headers = ["Authorization": "Bearer #{@token}", "x-api-key": @key]
    case HTTPoison.get(endpoint, headers) do
      {:ok, %{body: raw_body, status_code: code}} -> {code, raw_body}
      {:error, %{reason: reason}} -> {:error, reason}
    end
    |> (fn {ok, body} ->
      body
      |> Poison.decode(keys: :atoms)
      |> case do
        {:ok, parsed} -> {ok, parsed}
        _ -> {:error, body}
      end
    end).()
    |> (fn {200, results_map} ->
      results_map.results
    end).()
  end
end
