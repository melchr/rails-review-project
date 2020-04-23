class Album < ApplicationRecord #model in logic is re-usable, represents data to controller
    has_many :reviews, :dependent => :destroy
    has_many :users, through: :reviews
    has_one_attached :avatar
    accepts_nested_attributes_for :reviews
    validates_presence_of :artist
    validate :unique_title_by_artist
    scope :with_recent_reviews, -> { includes(:reviews).where(reviews: { date: [(Date.today - 7.days)..Date.tomorrow] }) } #scope shows range of reviews within 7 days, relies on include method and custom query on related model (reviews) 

    private

    def unique_title_by_artist #changes to downcase, checks if title already exists
        if Album.where('lower(title) = ? AND artist = ?', self.title.downcase, self.artist).count > 0
          @errors.add(:title, "must be unique to artist")
        end
    end

end
