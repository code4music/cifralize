class EmbedController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'embed'

  def show
    @song = Song.includes(:artist).find_by!(
      slug: params[:song],
      artist: Artist.find_by!(slug: params[:artist])
    )
    @transpose = params[:transpose].to_i
  end
end
