class Paper < ApplicationRecord
    validates :title, presence: true
    validates :venue, presence: true
end
