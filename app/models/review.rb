class Review < ActiveRecord::Base
    belongs_to :info
    belongs_to :user
end
