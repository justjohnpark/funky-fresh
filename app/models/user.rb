class User < ActiveRecord::Base
  has_many :pantry_participations
  has_many :pantries, through: :pantry_participations
  has_many :original_pantries, foreign_key: :creator_id, class_name: "Pantry"

  has_many :invitations, :class_name => "Invite", :foreign_key => "recipient_id"
  has_many :send_invitations, :class_name => "Invite", :foreign_key => "sender_id"

  validates :first_name, :last_name, :email, :password_digest, presence: true
  validates :email, uniqueness: :true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/ }
  # validates :password, :length => {:minimum => 6}

  has_secure_password

  before_save :capitalize_first_n_last_name, :lowercase_email

  def capitalize_first_n_last_name
    self.first_name = first_name.downcase.capitalize
    self.last_name = last_name.downcase.capitalize
  end

  def lowercase_email
    self.email = email.downcase
  end

  def all_pantries
    my_pantries = []
    my_pantries << self.original_pantries.to_a
    my_pantries << self.pantries.to_a
    my_pantries.flatten
  end

  def has_pantry?(pantry)
    self.all_pantries.include?(pantry)
  end

  def generate_token(column)  
    begin  
      self[column] = SecureRandom.urlsafe_base64  
    end while User.exists?(column => self[column])  
  end

  def send_password_reset  
  generate_token(:password_reset_token)  
  self.password_reset_sent_at = Time.zone.now  
  save!  
  UserMailer.password_reset(self).deliver  
end 


end
