defmodule ArtikelWeb.ArtikelController do
  use ArtikelWeb, :controller
  import Artikel.Client

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def list_articles(conn, _params) do
    article_list = get_articles()
    render(conn, "articles.html", articles: article_list)
  end

  def show_article(conn, %{"article_id" => article_id}) do
    {id, _} = Integer.parse(to_string article_id)
    article_detail = get_article(id)
    render(conn, "article.html", article: article_detail)
  end

  def search_article(conn, %{"keyword" => keyword}) do
    results = search_articles(keyword)
    render(conn, "articles.html", articles: results)
  end

end
