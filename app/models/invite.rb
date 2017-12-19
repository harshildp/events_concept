class Invite < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates :message, presence:true, length: {in: 10..250}
end
