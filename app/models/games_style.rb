class GamesStyle < ActiveRecord::Base
  extend GameHasManyTagJoin
  include GameHasManyTagJoin
end
