if defined? BetterErrors
  BetterErrors.editor = proc { |full_path, line|
    full_path = full_path.sub(Rails.root.to_s, '/Users/sean/Sites/tovgdb')
    "subl://open?url=file://#{full_path}&line=#{line}"
  }
end
