class InterviewImageUploader < Shrine
  include ImageProcessing::MiniMagick

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
end
