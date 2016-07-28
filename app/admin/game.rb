ActiveAdmin.register Game do
  menu priority: -100

  # Listing
  config.sort_order = 'name_asc'

  index do
    column 'Name', sortable: :name do |game|
      link_to game.name, admin_game_path(game)
    end
    column :published
    column :series, sortable: 'series.name'
    column 'Developers' do |game|
      game.games_creators.developers.map { |developer| developer.creator.name }.join('<br />').html_safe
    end
    column 'Publishers' do |game|
      game.games_creators.publishers.map { |publisher| publisher.creator.name }.join('<br />').html_safe
    end
    column :engine, sortable: 'engines.name'
    [:published_on, :initial_release_on,
     :minimum_number_of_players, :maximum_number_of_players,
     :local_play, :online_play, :coop_play, :competitive_play,
     :free, :freemium, :free_trial, :donation, :ads, :pay, :not_available].each do |game_attribute|
      column game_attribute
    end
    column 'Platforms' do |game|
      game.games_platforms.map(&:name).join('<br />').html_safe
    end
    column 'Distribution Channels' do |game|
      game.games_distribution_channels.map(&:name).join('<br />').html_safe
    end
    Game::MANY_TAGS.each do |tag|
      column "# of #{tag.pluralized}", sortable: Game.games_tags_count_column(tag) do |game|
        game.games_tags_count(tag)
      end
    end
    column :digital_distribution
    column :retail_distribution
    actions
  end

  controller do
    def scoped_collection
      super.includes :engine, :series
    end
  end

  # Show
  action_item(:new, only: :show) do
    link_to('New Game', new_admin_game_path)
  end

  show do
    attributes_table do
      row :name
      row :alternate_names
      row :published
      row :developers do
        if game.developers?
          game.games_creators.developers.each do |developer|
            text_node link_to developer.creator.name, admin_creator_path(developer.creator)
            text_node '<br>'.html_safe
          end
        end
      end
      row :publishers do
        if game.publishers?
          game.games_creators.publishers.each do |publisher|
            text_node link_to publisher.creator.name, admin_creator_path(publisher.creator)
            text_node '<br>'.html_safe
          end
        end
      end
      [:series, :engine, :published_on, :initial_release_on,
       :minimum_number_of_players, :maximum_number_of_players, :local_play, :online_play, :coop_play, :competitive_play,
       :free, :freemium, :free_trial, :donation, :ads, :pay, :not_available,
       :short_description, :long_description, :sources, :digital_distribution, :retail_distribution].each do |game_attribute|
        row game_attribute
      end
      row :platforms do
        if game.platforms?
          game.games_platforms.each do |game_platform|
            text_node link_to game_platform.platform.name, admin_platform_path(game_platform.platform)
            text_node " (#{game_platform.released_on})" if game_platform.released_on?
            text_node '<br>'.html_safe
          end
        end
      end
      row :old_raw_mediawiki_data do
        "<pre>#{game.old_raw_mediawiki_data}</pre>".html_safe
      end
    end

    panel 'Distribution Channels' do
      table_for game.games_distribution_channels do
        column :distribution_channel
        column :released_on
        column :uri do |game_distribution_channel|
          link_to game_distribution_channel.uri, game_distribution_channel.uri if game_distribution_channel.uri?
        end
      end
    end

    panel 'Links' do
      table_for game.links do
        column :link_type
        column :uri do |link|
          link_to link.uri, properly_linked_address(link.uri)
        end
        column :description_override
      end
    end

    panel 'Tags' do
      attributes_table_for '' do
        Game::MANY_TAGS.each do |tag|
          row tag.symbol_pluralized do
            game.send(tag.lowercase_pluralized).map(&:name).join(', ')
          end
        end
      end
    end

    panel 'Images' do
      table_for game.game_images do
        column :order
        column 'Image' do |game_image|
          text_node game_image.caption
          text_node '<br>'.html_safe
          text_node image_tag game_image.image.url
        end
      end
    end

    panel 'Videos' do
      table_for game.videos do
        column :title
        column :platform
        column :video_type
        column 'Video' do |video|
          text_node video_embed_code video
        end
      end
    end

    active_admin_comments
  end

  # New / Edit
  permit_params do
    params = [:name, :alternate_names, :series_id, :engine_id, :published_on, :initial_release_on, :short_description, :long_description, :sources,
              :digital_distribution, :retail_distribution,
              :minimum_number_of_players, :maximum_number_of_players, :local_play, :online_play, :coop_play, :competitive_play,
              :free, :freemium, :free_trial, :donation, :ads, :pay, :not_available,
              link_ids: [], links_attributes: [:id, :game_id, :link_type_id, :uri, :description_override, :_destroy],
              games_creators_ids: [], games_creators_attributes: [:id, :game_id, :creator_id, :developer, :publisher, :_destroy],
              game_image_ids: [], game_images_attributes: [:id, :game_id, :image, :caption, :order, :_destroy],
              video_ids: [], videos_attributes: [:id, :game_id, :title, :platform, :code, :video_type, :_update, :_create, :_destroy],
              games_platforms_ids: [], games_platforms_attributes: [:id, :game_id, :platform_id, :released_on, :_destroy],
              games_distribution_channels_ids: [], games_distribution_channels_attributes:
                [:id, :game_id, :distribution_channel_id, :released_on, :uri, :_destroy]]
    params << :published if current_admin_user.role == 'Super Admin'
    Game::MANY_TAGS.each do |tag|
      params.push "#{tag.lowercase}_ids".to_sym => [], "#{tag.lowercase}_attributes".to_sym => [:id, tag, :_update, :_create, :_destroy]
    end
    params
  end

  form html: { multipart: true } do |f|
    render partial: 'admin/admin_base_error_message', locals: { f: f }

    f.inputs 'Game Details' do
      f.input :name
      f.input :alternate_names
      f.input :published if current_admin_user.role == 'Super Admin'
      f.input :series, collection: Series.all
      f.input :engine, collection: Engine.all
      f.input :published_on, hint: 'Public date game was added to the database.'
      f.input :initial_release_on, hint: 'Date game was released to the public. Set to January 1 to display only the year on the public site.'
      [:minimum_number_of_players, :maximum_number_of_players, :local_play, :online_play, :coop_play, :competitive_play,
       :free, :freemium, :free_trial, :donation, :ads, :pay, :not_available,
       :short_description, :long_description, :sources, :digital_distribution, :retail_distribution].each do |game_attribute|
        f.input game_attribute
      end
    end

    f.inputs 'Creators' do
      f.has_many :games_creators, heading: '', new_record: 'Add New Creator', allow_destroy: true do |game_creator|
        game_creator.input :creator, collection: Creator.all
        game_creator.input :developer
        game_creator.input :publisher
      end
    end

    f.inputs 'Links' do
      f.has_many :links, heading: '', new_record: 'Add New Link', allow_destroy: true do |link|
        link.input :link_type, collection: (LinkType.where game_link: true)
        link.input :uri, as: :string
        link.input :description_override
      end
    end

    f.inputs 'Platforms' do
      f.has_many :games_platforms, heading: '', new_record: 'Add New Platform', allow_destroy: true do |game_platform|
        game_platform.input :platform, collection: Platform.all
        game_platform.input :released_on
      end
    end

    f.inputs 'Distribution Channels' do
      f.has_many :games_distribution_channels, heading: '', new_record: 'Add New Distribution Channel',
                                               allow_destroy: true do |game_distribution_channel|
        game_distribution_channel.input :distribution_channel, collection: DistributionChannel.all
        game_distribution_channel.input :released_on
        game_distribution_channel.input :uri, as: :string
      end
    end

    panel 'Tags' do
      Game::MANY_TAGS.each do |tag|
        f.inputs do
          f.input tag.symbol_pluralized, as: :check_boxes
        end
      end
    end

    f.inputs 'Images' do
      f.has_many :game_images, heading: '', new_record: 'Add New Image', allow_destroy: true do |image|
        image.input :caption
        image.input :order, hint: 'Lowest ordered image will be thumbnail throughout site thumbnail.'
        if image.object.new_record?
          image.input :image, as: :file
        else
          image.input :image, as: :file, hint: image_tag(image.object.image.url)
        end
      end
    end

    f.inputs 'Videos' do
      f.has_many :videos, heading: '', allow_destroy: true do |video|
        video.input :title
        video.input :platform, collection: Video::PLATFORMS
        video.input :video_type, collection: Video::VIDEO_TYPES
        video.input :code
      end
    end

    f.actions
  end
end
