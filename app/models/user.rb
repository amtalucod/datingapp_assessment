class User < ApplicationRecord
    before_save { self.email = email.downcase }
    validates :first_name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
    has_secure_password     
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true           
       
    
    
    # Returns the hash digest of the given string.
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
                                                    BCrypt::Password.create(string, cost: cost)
    end
    
    #validate :validate_image_count

    #def validate_image_count
    #    if images.length < 1
    #    errors.add(:base, "At least one image is required")
    #    elsif images.length > 5
    #    errors.add(:base, "Maximum of five images allowed")
    #    end
    #end

    #def add_image_url(image_url)
    #    self.image_urls ||= []
    #    self.image_urls << image_url
    #    self.save
    #end
    
    
    belongs_to :location
    accepts_nested_attributes_for :location 
    
    has_many :swipes
    has_many :liked_swipes, class_name: 'Swipe', foreign_key: 'user_id', dependent: :destroy
    has_many :disliked_swipes, class_name: 'Swipe', foreign_key: 'user_id', dependent: :destroy
    
    has_many :sent_messages, class_name: 'Message'
    has_many :received_messages, class_name: 'Message'
  
    has_many :images
    accepts_nested_attributes_for :images
    
    #has_many_attached :photos
    #has_one_attached :photos
    
    
    #has_one_attached :photos
#
    #after_create_commit :upload_image_to_cloudinary
#
    #private
#
    #def upload_image_to_cloudinary
    #    response = Cloudinary::Uploader.upload(self.photo)
    #    self.update(image_url: response['secure_url'])
    #end
end
