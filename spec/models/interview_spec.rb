require 'rails_helper'

RSpec.describe Interview, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:content_preview) }
    it { is_expected.to validate_presence_of(:interviewee_full_name) }
    it { is_expected.to validate_presence_of(:interviewee_synopsis) }
    it { is_expected.to validate_presence_of(:read_more_link) }
  end
end
