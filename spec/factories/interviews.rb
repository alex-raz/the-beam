# == Schema Information
#
# Table name: interviews
#
#  id                    :integer          not null, primary key
#  content_preview       :text
#  interviewee_full_name :string
#  interviewee_synopsis  :string
#  read_more_link        :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  image_data            :text
#

FactoryGirl.define do
  factory :interview do
    content_preview 'Lorem Ipsum'
    interviewee_full_name 'John Doe'
    interviewee_synopsis 'true identity is unknown or must be withheld in a legal action'
    read_more_link 'http://example.com'
    image File.open('spec/fixtures/300px_copy.jPg')
  end
end
