class Product < ApplicationRecord
  belongs_to :category, optional: true
  validates :title, :description, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  before_save :strip_html_from_description, :set_title_lowercase
  # before_save :title_shorter_than_description
  validate :title_shorter_than_description

  def strip_html_from_description
    self.description = ActionView::Base.full_sanitizer.sanitize(description)
  end

  def title_shorter_than_description

    if title.present? && description.present? && self.title.length > self.description.length
      errors.add(:title, "have to be shorter than Desciption")
      # throw(:abort)
    end
  end

  def set_title_lowercase
    self.title = title.downcase
  end

end
