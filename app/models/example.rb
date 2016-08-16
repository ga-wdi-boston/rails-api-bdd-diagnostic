# An example for user of the template
class Example < ActiveRecord::Base
  belongs_to :user
  has_many :others
  validates :text, :user, presence: true
end
