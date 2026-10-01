class Carrinho < ApplicationRecord
  belongs_to :user
  has_many :item_carrinhos, dependent: :destroy

  def total
    item_carrinhos.includes(:produto).sum { |i| i.quantidade.to_i * i.produto.preco }
  end
end
