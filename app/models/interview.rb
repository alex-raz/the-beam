class Interview < ApplicationRecord
  validates :content_preview,
            :interviewee_full_name,
            :interviewee_synopsis,
            :read_more_link,
            presence: true
end
