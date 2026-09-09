class Produto < ApplicationRecord
    has_many :item_carrinho
    has_many :item_pedido
    has_one_attached :imagem
end
