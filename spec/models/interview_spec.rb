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

require 'rails_helper'

RSpec.describe Interview, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:content_preview) }
    it { is_expected.to validate_presence_of(:interviewee_full_name) }
    it { is_expected.to validate_presence_of(:interviewee_synopsis) }
    it { is_expected.to validate_presence_of(:read_more_link) }
    it { is_expected.to validate_presence_of(:image_data) }
  end
end
