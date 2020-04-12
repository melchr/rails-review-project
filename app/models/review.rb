class Review < ApplicationRecord
    belongs_to :album, optional: true #<<<< i think this line saved my life
    belongs_to :user
    accepts_nested_attributes_for :album
end
