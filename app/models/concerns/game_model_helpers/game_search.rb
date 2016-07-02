module GameModelHelpers
  module GameSearch
    def search_for(query, match_type = 'all')
      __elasticsearch__.search(
        query: {
          multi_match: {
            query: query,
            type: 'cross_fields',
            operator: match_type == 'all' ? 'and' : 'or',
            fields: ['name^3', 'long_description'],
            analyzer: 'standard'
          }
        },
        filter: {
          term:  { published: true }
        },
        highlight: {
          fields: { '*': {} }
        }
      )
    end
  end
end
