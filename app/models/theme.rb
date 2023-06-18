class Theme < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  mount_uploader :logo, LogoUploader

  belongs_to :user

  validates :header_color, presence: true

  enum default_theme: {
    header_color: nil,
    banner: nil,
    logo: nil
  }
end
