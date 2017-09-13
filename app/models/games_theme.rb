class GamesTheme < ApplicationRecord
  extend GameHasManyTagJoin
  include GameHasManyTagJoin
end
