class Event < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :attendees, dependent: :destroy
  has_many :users, through: :attendees
  has_many :invites

  validates :user, :date, :time, presence: true
  validates :name, presence: true, length: {minimum: 4}
  validates :location, presence: true, length: {minimum: 3}
  validates :state, presence: true
  validates :description, presence: true, length: {in: 10..500}

  validate :check_state
  validate :check_date

  before_save :set_case

  private
    def check_state
      states = %w(AK AL AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO MS MT NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VA VT WA WI WV WY)
      if state.present? 
        errors.add(:state, "given is invalid") unless states.include? state.upcase
      end
    end

    def check_date
      errors.add(:date, "must be in the future") if date.present? && date < Date.current
    end

    def set_case
      self.location = self.location.titleize
      self.state.upcase!
    end
end
