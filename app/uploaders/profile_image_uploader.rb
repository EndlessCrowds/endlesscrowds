# encoding: utf-8

class ProfileImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  version :thumb
  version :thumb_avatar

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
    "/assets/catarse/icon_person.png"
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end


  #user thumb
  version :thumb do
    process resize_to_fill: [260,170]
    process convert: :png
  end

  version :thumb_avatar do
    process resize_to_fit: [300,300]
    process convert: :png
  end

end
