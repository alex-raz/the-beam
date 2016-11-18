class CreateInterviews < ActiveRecord::Migration[5.0]
  def change
    create_table :interviews do |t|
      t.text :content_preview
      t.string :interviewee_full_name
      t.string :interviewee_synopsis
      t.string :read_more_link

      t.timestamps
    end
  end
end
