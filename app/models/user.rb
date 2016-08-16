#
class User < ActiveRecord::Base
  include Authentication
  has_many :examples, inverse_of: :example
end
