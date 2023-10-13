class Public::HomesController < ApplicationController
  def top
    @galleries = Gallery.all
  end
end
