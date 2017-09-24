if Rails.env.development?
  Bullet.enable = true
  Bullet.bullet_logger = true
  Bullet.add_footer = true
end
