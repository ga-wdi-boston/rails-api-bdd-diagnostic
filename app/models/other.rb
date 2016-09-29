class Example < ActiveRecord::Base
  belongs_to :example
  validates :text, :user, presence: true
end
