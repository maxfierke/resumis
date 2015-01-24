# encoding: utf-8

class HeaderVideoUploader < CarrierWave::Uploader::Base
  include CarrierWave::Video
  include ::CarrierWave::Backgrounder::Delay

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(webm mp4 mov m4v flv avi)
  end

  version :webm do
    process :encode_video => [:webm, resolution: '1920x1080', preserve_aspect_ratio: :width]

    def full_filename(for_file)
      "#{File.basename(for_file, File.extname(for_file))}.webm"
    end
  end

  version :mp4 do
    process :encode_video => [:mp4, resolution: '1920x1080', preserve_aspect_ratio: :width]

    def full_filename(for_file)
      "#{File.basename(for_file, File.extname(for_file))}.mp4"
    end
  end
end
