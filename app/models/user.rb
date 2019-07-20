class User < ApplicationRecord
  has_many :instruments, inverse_of: :user, dependent: :destroy
  has_many :songs, inverse_of: :user, dependent: :destroy
  has_many :elements, through: :songs, inverse_of: :user, dependent: :destroy
  validates :email, :username, :password, :password_confirmation, presence: true
  validates :email, :username, uniqueness: { case_sensitive: false }
  has_secure_password

  def self.find_or_create_from_auth_hash(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
			user.provider = auth.provider
			user.uid = auth.uid
			user.email = auth.info.email
      user.username = auth.info.name
      user.password = SecureRandom.hex
      user.password_confirmation = user.password
			user.save
		end
  end



end
