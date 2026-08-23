class Pedido < ApplicationRecord
  belongs_to :user
  has_many :item_pedido, dependent: :destroy

end
