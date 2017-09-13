class GamesStyle < ApplicationRecord
  extend GameHasManyTagJoin
  include GameHasManyTagJoin
end
