class BuildingsController < ApplicationController
  def upload
    upload = params[:buildings_csv]
    return render json: { error: ["Empty csv"] } if upload.nil?

    uploader = BuildingUploader.new
    uploader.upload_csv(CSV.parse(upload.read))
    if uploader.errors.none?
      return render status: 200, json: { }
    else
      return render status: 403, json: { errors: uploader.errors }
    end
  end
end
