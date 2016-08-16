class AddExampleToUser < ActiveRecord::Migration
  def change
    add_reference :users, :example, index: true, foreign_key: true
  end
end
