class SentMail < ActiveRecord::Base
	before_save { self.sender_address = sender_address.downcase }
	before_save { self.recipient_address = recipient_address.downcase }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :sender_address, 		presence: true, length: { maximum: 255 },
									format: { with: VALID_EMAIL_REGEX }

	validates :recipient_address, 	presence: true, length: { maximum: 255 },
									format: { with: VALID_EMAIL_REGEX }

	validates :subject,				length: { maximum: 255 }

	validate :user_addresses


	private
	  def user_addresses
	  	if ( !User.exists?(email: self.sender_address) || !User.exists?(email: self.recipient_address))
	  	  self.errors.add(:base, "Sender & recipient addresses must be users' addresses")
	  	end
	  end
end
