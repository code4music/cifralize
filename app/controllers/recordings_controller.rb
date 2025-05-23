class RecordingsController < ApplicationController
  before_action :set_recording, only: %i[ show edit update destroy ]

  def index
    if current_user.role == Role.admin
      @recordings = Recording.all
    else
      @recordings = current_user.recordings
    end

    @recordings = @recordings.order(created_at: :desc).page(params[:page]).per(20)
  end

  def show; end

  def new
    @recording = Recording.new
  end

  def create
    @recording = Recording.new(recording_params)
    @recording.user = current_user

    respond_to do |format|
      if @recording.save
        format.html { redirect_to recordings_path, notice: "Gravação salva com sucesso." }
        format.json { render :show, status: :created, location: @recording }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recording.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recording.destroy

    respond_to do |format|
      format.html { redirect_to recordings_url, notice: "Recording was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def set_recording
    @recording = Recording.find_by(uuid: params[:id])
  end

  def recording_params
    params.require(:recording).permit(:audio_file, :title, :description, :visibility, :likes_count, :views_count)
  end
end
