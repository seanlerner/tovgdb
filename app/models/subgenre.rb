class Subgenre < GameHasManyTag
  include GameHasManyTagModule
  self.table_name = name.downcase.pluralize
end
