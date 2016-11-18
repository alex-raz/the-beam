# == Schema Information
#
# Table name: testimonials
#
#  id               :integer          not null, primary key
#  content          :text
#  reader_full_name :string
#  reader_link      :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Testimonial < ApplicationRecord
  validates :content, :reader_full_name, presence: true
end
