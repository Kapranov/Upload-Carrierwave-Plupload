# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  include CarrierWave::ImageOptimizer

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :convert => 'png'
  process :watermark
  version :thumb do
    process :resize_to_limit => [200, 200]
    process optimize: [{ quality: 50 }]
  end
  version :index do
    process :resize_to_limit => [400, 400]
    process optimize: [{ quality: 50 }]
  end

  def watermark
    manipulate! do |img|
      logo = Magick::Image.read("#{Rails.root}/app/assets/images/logo.png").first
      img = img.composite(logo, Magick::NorthWestGravity, 0, 0, Magick::OverCompositeOp)
    end
  end

end
