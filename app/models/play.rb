class Play < ApplicationRecord
  serialize :positions, Hash

  belongs_to :user
end
