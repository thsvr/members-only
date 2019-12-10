# frozen_string_literal: true

class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 70 }
  validates :content, presence: true, length: { minimum: 10 }

  belongs_to :user
end
