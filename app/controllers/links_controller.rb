class LinksController < ApplicationController
  def new; end

  def create
    link = Link.create(url: request.raw_post)
    if link.valid?
      render plain: "#{request.base_url}/#{link.short_url}"
    else
      render plain: "The input is not a valid url. (Don't forget to add 'http' or 'htpps' at the beginning of your url)"
    end
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
