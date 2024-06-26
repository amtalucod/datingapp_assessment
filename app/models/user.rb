class User < ApplicationRecord
    has_many :images, dependent: :destroy
    accepts_nested_attributes_for :images
    
    belongs_to :location
    accepts_nested_attributes_for :location 
    
    has_many :swipes, dependent: :destroy
    has_many :liked_swipes, class_name: 'Swipe', foreign_key: 'user_id', dependent: :destroy
    has_many :disliked_swipes, class_name: 'Swipe', foreign_key: 'user_id', dependent: :destroy
    
    has_many :sent_messages, class_name: 'Message'
    has_many :received_messages, class_name: 'Message'
    
    
    before_save { self.email = email.downcase }
    validates :first_name, presence: true, length: { maximum: 50 }
    validates :last_name, presence: true, length: { maximum: 50 }
    validates :mobile_number, presence: true, length: { minimum: 11, maximum: 15 }, uniqueness: true,
                    format: { with: /\A[\d\+]+\z/, message: "only allows numerical digits" }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
    validates :birthdate, presence: true     
    validates :gender, presence: true  
    validates :sexual_orientation, presence: true             
    validates :gender_interest, presence: true  
    validates :bio, presence: true, length: { maximum: 300 }  
      has_secure_password     
     validates :password, presence: true, length: { minimum: 6 }, allow_nil: true           
    
    validate :validate_photo_count, on: :create
    private
    def validate_photo_count
        splitted_photos = photos.split(",").length
        final_count = (splitted_photos - 1) / 4
        if final_count < 1
        errors.add(:base, "At least one photo is required")
        elsif final_count > 5
        errors.add(:base, "Maximum of 5 photos allowed")
        end
    end

    # Returns the hash digest of the given string.
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
                                                    BCrypt::Password.create(string, cost: cost)
    end
end
