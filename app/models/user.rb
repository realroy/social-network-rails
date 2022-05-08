class User < ApplicationRecord
  has_many :access_tokens, dependent: :destroy
end
