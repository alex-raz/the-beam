class CreateTestimonials < ActiveRecord::Migration[5.0]
  def change
    create_table :testimonials do |t|
      t.text :content
      t.string :reader_full_name
      t.string :reader_link

      t.timestamps
    end
  end
end
