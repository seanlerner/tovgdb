class GamesGenre < ApplicationRecord
  extend GameHasManyTagJoin
  include GameHasManyTagJoin
end
