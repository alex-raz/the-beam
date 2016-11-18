FactoryGirl.define do
  factory :interview do
    content_preview 'Lorem Ipsum'
    interviewee_full_name 'John Doe'
    interviewee_synopsis 'true identity is unknown or must be withheld in a legal action'
    read_more_link 'http://example.com'
  end
end
