class LinksController < ApplicationController
  def new
    @short_url = params[:short_url]
    @link = Link.new
  end

  def create
    link = Link.create(link_params)
    redirect_to root_path(short_url: link.short_url)
  end

  def show
    link = Link.find_by short_url: params[:short_url]
    if link
      redirect_to link.url
    else
      redirect_to root_path
    end
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end
end
