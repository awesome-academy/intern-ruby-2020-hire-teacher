class Country < ApplicationRecord
  has_many :locations, dependent: :destroy
end
