class GamesAward < ActiveRecord::Base
  extend GameHasManyTagJoin
  include GameHasManyTagJoin
end
