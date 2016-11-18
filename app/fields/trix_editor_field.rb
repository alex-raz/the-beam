require "administrate/field/base"

class TrixEditorField < Administrate::Field::Base
  def to_s
    data
  end

  def raw_html
    data.html_safe
  end
end
