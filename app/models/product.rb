class Product < ApplicationRecord
  validates :title, :description, presence: true
  validates :price, numericality: { greater_than: 0 }

end
