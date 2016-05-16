class Engine < GameHasOneTag
  include GameHasOneTagModule
  self.table_name = name.downcase.pluralize
end
