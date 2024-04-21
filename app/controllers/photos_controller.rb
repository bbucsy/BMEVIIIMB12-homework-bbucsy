class PhotosController < ApplicationController
  before_action :set_photo, only: %i[ destroy ]
  http_basic_authenticate_with(
    name: Rails.application.credentials.dig(:login, :username),
    password: Rails.application.credentials.dig(:login, :password),
  ) if Rails.env.production?


  # GET /photos or /photos.json
  def index

    sort_column = params[:sort] || "created_at"
    if sort_column == "name"
      sort_column = 'LOWER(name)'
    end
    sort_direction = params[:direction].presence_in(%w[asc desc]) || "desc"

    @photos = Photo.order("#{sort_column} #{sort_direction}").page(params[:page]).per(10)
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # POST /photos or /photos.json
  def create
    @photo = Photo.new(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to photos_url, notice: "Photo was successfully created." }
        format.json { render json: @photo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1 or /photos/1.json
  def destroy
    @photo.destroy!

    respond_to do |format|
      format.html { redirect_to photos_url, notice: "Photo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_photo
    @photo = Photo.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def photo_params
    params.require(:photo).permit(:name, :image)
  end
end
