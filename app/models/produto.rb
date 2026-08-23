class Produto < ApplicationRecord
    has_many :item_carrinho
    has_many :item_pedido
end
