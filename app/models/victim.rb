class Victim < ActiveRecord::Base

has_many :signups
has_many :shelters, through: :signups



VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
	before_save {self.email = email.downcase}
	
	validates :email, presence: :true,
				format: {with: VALID_EMAIL_REGEX},
				uniqueness: {case_sensitive: false}

	validates :password, length: {minimum: 6}

	before_create :create_remember_token
	has_secure_password
	
	def Victim.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def Victim.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private
	def create_remember_token
		self.remember_token = Victim.digest(Victim.new_remember_token)
	end
end
