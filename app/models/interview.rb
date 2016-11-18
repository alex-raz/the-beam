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

class Interview < ApplicationRecord
  validates :content_preview,
            :interviewee_full_name,
            :interviewee_synopsis,
            :read_more_link,
            presence: true
end
