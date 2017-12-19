class User < ActiveRecord::Base
  has_secure_password
  has_many :events
  has_many :comments
  has_many :attendees, dependent: :destroy
  has_many :events_attending, through: :attendees, source: :event
  has_many :invites

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i  

  validates :first_name, :last_name, :location, presence: true , length:{minimum: 2}
  validates :state, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :password, length: {minimum: 7, allow_blank:true}

  validate :check_state
  before_save :set_case

  private
    def check_state
      states = %w(AK AL AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO MS MT NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VA VT WA WI WV WY)
      if state.present?
        errors.add(:state, "given is invalid") unless states.include? state.upcase
      end
    end

    def set_case
      self.state.upcase!
      self.email.downcase!
      self.location = self.location.titleize
    end
end
