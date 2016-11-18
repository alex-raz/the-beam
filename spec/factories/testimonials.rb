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

FactoryGirl.define do
  factory :testimonial do
    content 'Lorem Ipsum'
    reader_full_name 'Reader Name'
    reader_link 'http://example.com/reader_link'
  end
end
