class ClothingItem < ApplicationRecord
  CATEGORY = %w[
    tshirt shirt hoodie sweater pants jeans shorts skirt dress jacket coat shoes hat scarf bag other
  ].freeze

  validates :category, presence: true
  validates :color_primary_hex, format: /\A#?[0-9A-Fa-f]{6}\z/, allow_blank: true
  validates :category, inclusion: { in: CATEGORY }, allow_blank: true
end
