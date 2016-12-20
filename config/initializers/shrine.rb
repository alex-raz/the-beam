require 'shrine'
require 'shrine/storage/file_system'
require 'image_processing/mini_magick'

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'),
  store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/store'),
}

Shrine.plugin :remove_invalid
Shrine.plugin :activerecord
Shrine.plugin :determine_mime_type
Shrine.plugin :logging, logger: Rails.logger
Shrine.plugin :remove_attachment
Shrine.plugin :store_dimensions
Shrine.plugin :validation_helpers
Shrine.plugin :versions
Shrine.plugin :cached_attachment_data
Shrine.plugin :delete_raw # delete processed files after uploading
