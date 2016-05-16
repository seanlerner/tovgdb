module GameTagHelper
  # Class Methods
  def lowercase
    to_s.downcase
  end

  def pluralized
    to_s.pluralize
  end

  def lowercase_pluralized
    pluralized.downcase
  end

  def css_class
    lowercase
  end

  def symbol
    lowercase.to_sym
  end

  def symbol_pluralized
    lowercase_pluralized.to_sym
  end
end
