class Review < ApplicationRecord
    #attr_accessible :title, :date, :content, :user_id, :album_id
    belongs_to :album, optional: true #<<<< i think this line saved my life
    belongs_to :user
    validates_presence_of :content
    validates :title, presence: true, uniqueness: true
    validates :date, presence: true
    accepts_nested_attributes_for :album
    scope :recent, -> { where("date(date) >= ?", Date.today - 7.days) } #scope
end
