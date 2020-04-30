class Album < ApplicationRecord 
    has_many :reviews, :dependent => :destroy
    has_many :reviewers, through: :reviews, source: :user
    belongs_to :user
    
    has_one_attached :avatar
    accepts_nested_attributes_for :reviews
    validates_presence_of :artist
    validates_presence_of :title
    validate :unique_title_by_artist
    scope :with_recent_reviews, -> { includes(:reviews).where(reviews: { date: [(Date.today - 7.days)..Date.tomorrow] }) } 

    private

    def unique_title_by_artist
        if Album.where('lower(title) = ? AND artist = ?', self.title.downcase, self.artist).count > 0
          @errors.add(:title, "must be unique to artist")
        end
    end

end

