class RefreshToken < ApplicationRecord
  belongs_to :user
  before_create :set_crypted_token

  attr_accessor :token

  class << self
    def find_by_token(crypted_token)
      RefreshToken.find_by(crypted_token: crypted_token)
    end
  end

  private

  def set_crypted_token
    self.token = SecureRandom.hex
    self.crypted_token = Digest::SHA256.hexdigest(token)
  end
end
