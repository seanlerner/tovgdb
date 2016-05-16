class GamesSubgenre < ActiveRecord::Base
  extend GameHasManyTagJoin
  include GameHasManyTagJoin
end
