class MultirecordingsController < ApplicationController
  before_action :set_multirecording, only: %i[ show edit update destroy ]

  def index
    @multirecordings = Multirecording.all
  end

  def show; end

  def new
    @multirecording = Multirecording.new
  end

  def edit; end

  def create
    @multirecording = Multirecording.new(multirecording_params)
    @multirecording.user = current_user

    if @multirecording.save
      if params[:multirecording][:tracks]
        params[:multirecording][:tracks].each do |track|
          @multirecording.tracks.attach(track)
        end
      end
      redirect_to @multirecording, notice: "Gravação criada."
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @multirecording.update(multirecording_params)
        format.html { redirect_to multirecording_url(@multirecording), notice: "Multirecording was successfully updated." }
        format.json { render :show, status: :ok, location: @multirecording }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @multirecording.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @multirecording.destroy

    respond_to do |format|
      format.html { redirect_to multirecordings_url, notice: "Multirecording was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def set_multirecording
    @multirecording = Multirecording.find(params[:id])
  end

  def multirecording_params
    params.require(:multirecording).permit(:user_id, :title, tracks: [])
  end
end
