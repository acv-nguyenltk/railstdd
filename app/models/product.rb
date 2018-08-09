class Product < ApplicationRecord
  belongs_to :category, optional: true
  validates :title, :description, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  before_save :strip_html_from_description, :set_title_lowercase

  def strip_html_from_description
    self.description = ActionView::Base.full_sanitizer.sanitize(description)
  end
  #checked presence so no need check blank?
  def title_shorter_than_description
    errors.add(:title, "Title have to be shorter than Desciption") if self.title.length > self.description.length
  end

  def set_title_lowercase
    self.title = title.lowercase
  end

end
