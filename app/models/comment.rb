class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates :user, :event, presence: true
  validates :content, presence: true, length: {in: 5..250}
end
