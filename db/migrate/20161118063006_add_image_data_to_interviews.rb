class AddImageDataToInterviews < ActiveRecord::Migration[5.0]
  def change
    add_column :interviews, :image_data, :text
  end
end
