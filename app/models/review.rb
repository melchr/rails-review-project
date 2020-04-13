class Review < ApplicationRecord
    #attr_accessible :title, :date, :content, :user_id, :album_id
    belongs_to :album, optional: true #<<<< i think this line saved my life
    belongs_to :user
    accepts_nested_attributes_for :album
end
