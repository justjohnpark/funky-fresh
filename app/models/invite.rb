class Invite < ActiveRecord::Base
  belongs_to :pantry
  belongs_to :sender, :class_name => "User"
  belongs_to :recipient, :class_name => "User"

  validates :email, presence: true
  validates :pantry, presence: true
  validates :sender, presence: true

  before_create :generate_token, :set_recipient_id

  def generate_token
     self.token = Digest::SHA1.hexdigest([self.pantry_id, Time.now, rand].join)
  end

  def set_recipient_id
    recipient = User.find_by_email(email)
    if recipient
      self.recipient_id = recipient.id
    end
  end

  def is_a_user?
    !!User.find_by_email(self.email)
  end

  def sort_n_send
    recipient = User.find_by_id(self.recipient_id)
    pantry_object = Pantry.find_by_id(self.pantry_id)
    if self.is_a_user? && recipient.has_pantry?(pantry_object)
    elsif self.is_a_user? && !recipient.has_pantry?(pantry_object)
      InviteMailer.existing_user_invite(self).deliver
      self.recipient.pantries.push(self.pantry)
    else
      puts "I AM THE TOKEN #{}"
      InviteMailer.new_user_invite(self, 'http://localhost:3000' + Rails.application.routes.url_helpers.new_user_path(:invite_token => self.token)).deliver
    end
  end

end

