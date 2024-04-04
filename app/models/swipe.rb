class Swipe < ApplicationRecord
    belongs_to :user
    belongs_to :liked_user, class_name: 'User', foreign_key: 'liked_user_id', optional: true
    belongs_to :disliked_user, class_name: 'User', foreign_key: 'disliked_user_id', optional: true

    has_many :messages, dependent: :destroy
    
    
end
