class InterviewImageUploader < Shrine
  include ImageProcessing::MiniMagick
  plugin :processing
  plugin :delete_raw # delete processed files after uploading

  Attacher.validate do
    validate_extension_inclusion(
      [/(?i)(jp?g|png|gif)$/],
      message: "isn't in allowed format (only .jpg, .png, .gif are supported)"
    )
    validate_min_width 150
    validate_min_height 150
    validate_max_size 5.megabytes, message: 'is too large (max is 5 MB)'
    validate_min_size 4.kilobytes, message: 'is smaller than 5 KB' # to avoid size collisions
    validate_mime_type_inclusion ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']
    validate_max_width 4000
    validate_max_height 4000
  end

  process(:store) do |io, context|
    x1200 = resize_to_limit(io.download, 1200, 1200)
    { original: io, x1200: x1200 }
  end

  def crop_image(record, crop_data)
    file = crop(record.image[:x1200].download, *crop_data)
    resize_to_limit!(file, 332, 332)
    attacher = record.image_attacher
    cropped = attacher.store!(file, version: :cropped)
    attacher.swap(record.image.merge!(cropped: cropped))
  end
end
