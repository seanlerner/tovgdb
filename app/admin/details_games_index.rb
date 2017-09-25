ActiveAdmin.register_page 'Detailed Games List' do
  menu parent: 'games'

  fields = %i[
    published
    publication_status
    published_on
    initial_release_on
    minimum_number_of_players
    maximum_number_of_players
    local_play
    online_play
    coop_play
    competitive_play
    free
    freemium
    free_trial
    donation
    ads
    pay
    not_available
    digital_distribution
    retail_distribution
  ]

  associations = {
    'Developers'            => -> (game) { game.games_creators.select(&:developer) },
    'Publishers'            => -> (game) { game.games_creators.select(&:publisher) },
    'Series'                => -> (game) { [game.series]                           },
    'Engine'                => -> (game) { [game.engine]                           },
    'Platforms'             => -> (game) { game.platforms                          },
    'Genres'                => -> (game) { game.genres                             },
    'Themes'                => -> (game) { game.themes                             },
    'Styles'                => -> (game) { game.styles                             },
    'Communities'           => -> (game) { game.communities                        },
    'Distribution Channels' => -> (game) { game.distribution_channels              }
  }

  content do
    table do
      thead do
        tr do
          th 'Name'

          th ''

          associations.keys.each do |association_title|
            th association_title
          end

          fields.each do |field|
            th field.to_s.humanize
          end
        end
      end

      tbody do
        Game.all.includes(
          :games_creators, :creators, :series, :engine, :distribution_channels,
          :platforms, :themes, :genres, :styles, :communities
        ).each do |game|
          tr do
            td link_to game.name, admin_game_path(game)

            td do
              [link_to('View',   admin_game_path(game)),
               link_to('Edit',   edit_admin_game_path(game)),
               link_to('Delete', admin_game_path(game), method: :delete)].join(' ').html_safe
            end

            associations.values.each do |association_data|
              th do
                data = association_data.call(game)
                data.map(&:name).join(', ') if data.any?
              end
            end

            fields.each do |game_attribute|
              td game.send game_attribute
            end
          end
        end
      end

      hr
    end
  end
end
