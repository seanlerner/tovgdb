class Series < GameHasOneTag
  include GameHasOneTagModule
  self.table_name = name.downcase.pluralize
end
