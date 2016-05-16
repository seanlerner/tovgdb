module SharedMethods
  def remove_last_word(string)
    string.split(' ')[0...-1].join(' ')
  end
end
