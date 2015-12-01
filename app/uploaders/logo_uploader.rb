# encoding: utf-8

class LogoUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  def extension_white_list
    %w(jpg jpeg gif png) unless mounted_as == :video_thumbnail
  end

  def self.choose_storage
    if Rails.env.production? && defined? Configuration
      (Configuration[:aws_access_key]) ? :fog : :file
    else
      # We should be running initial migrations to be here. The Configuration model does not yet exist to be read from
    end
  end

  storage choose_storage

  def default_url
    "/assets/catarse/default_image_movie.png"
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  version :project_thumb do
    process resize_to_fill: [440,344]
    process convert: :png
  end

  version :project_thumb_small, from_version: :project_thumb do
    process resize_to_fill: [85,67]
    process convert: :png
  end

  #facebook requires a minimum thumb size
  version :project_thumb_facebook do
    process resize_to_fill: [512,400]
    process convert: :png
  end


end
