class SentMail < ActiveRecord::Base
	before_save { self.sender_address = sender_address.downcase }
	before_save { self.recipient_adress = recipient_adress.downcase }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :sender_address, 		presence: true, length: { maximum: 255 },
									format: { with: VALID_EMAIL_REGEX }

	validates :recipient_address, 	presence: true, length: { maximum: 255 },
									format: { with: VALID_EMAIL_REGEX }

	validates :subject,				length: { maximum: 255 }
	validates :created_at,			presence: true
end
