if Rails.env.development?
  Bullet.enable = true
  Bullet.bullet_logger = true
  Bullet.add_footer = true
  Bullet.add_whitelist type: :unused_eager_loading, class_name: 'Game', association: :creators
end
