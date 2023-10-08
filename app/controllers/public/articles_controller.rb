class Public::ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Item.find(params[:id])
  end
end
