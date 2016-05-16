class GamesGenre < ActiveRecord::Base
  extend GameHasManyTagJoin
  include GameHasManyTagJoin
end
