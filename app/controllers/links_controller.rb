class LinksController < ApplicationController


  def show
    link = Link.find_by short_url: params[:short_url]
    redirect_to link.url
  end


end
