class User < ApplicationRecord
  has_many :instruments, inverse_of: :user
  has_many :songs, inverse_of: :user
  has_many :elements, through: :songs, inverse_of: :user
  has_secure_password
  validates :email, :username, :password, :password_confirmation, presence: true
  validates :email, :username, uniqueness: true

  def self.find_or_create_from_auth_hash(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
			user.provider = auth.provider
			user.uid = auth.uid
			user.email = auth.info.email
      user.username = auth.info.email
      user.password = SecureRandom.hex
			user.save(validate: false)
		end
  end
end
