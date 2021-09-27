class Connection < ApplicationRecord
    belongs_to :store
    belongs_to :user
    validates :user_id, uniqueness: {scope: :store_id}
end
