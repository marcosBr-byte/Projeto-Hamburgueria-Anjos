class Carrinho < ApplicationRecord
  belongs_to :user
  has_many :item_carrinho, dependent: :destroy
end
