class Album < ApplicationRecord
    has_many :reviews
    has_many :users, through: :reviews
    has_one_attached :avatar
    accepts_nested_attributes_for :reviews
    validates_presence_of :artist
    validates_presence_of :title
    scope :with_recent_reviews, -> { includes(:reviews).where(reviews: { date: [(Date.today - 7.days)..Date.tomorrow] }) } #scope relies on include method and custom query on related model (reviews)
end
