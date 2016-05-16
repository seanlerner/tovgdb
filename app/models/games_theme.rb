class GamesTheme < ActiveRecord::Base
  extend GameHasManyTagJoin
  include GameHasManyTagJoin
end
