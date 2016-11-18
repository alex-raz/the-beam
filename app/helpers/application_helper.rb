module ApplicationHelper
  def reader_cite(testimonial)
    return testimonial.reader_full_name unless testimonial.reader_link

    link_to(testimonial.reader_full_name, testimonial.reader_link)
  end
end
