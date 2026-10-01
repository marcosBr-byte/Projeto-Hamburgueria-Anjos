class ItemCarrinhoController < ApplicationController
  before_action :buscar_item, only: [:atualizar, :remover] # rubocop:disable Layout/SpaceInsideArrayLiteralBrackets

  def atualizar
    if params[:quantidade].to_i > 0
      @item.update(quantidade: params[:quantidade])
    else
      @item.destroy
    end
    atualizar_total
    redirect_to carrinho_path, notice: "Carrinho atualizado."
  end

  def remover
    carrinho = @item.carrinho
    @item.destroy
    atualizar_total(carrinho)
    redirect_to carrinho_path, notice: "Item removido do carrinho."
  end

  private

  def buscar_item
    @item = Itemcarrinho.find(params[:id])
  end

  def atualizar_total(carrinho = @item.carrinho)
    total = carrinho.item_carrinho.includes(:produto).sum { |item| item.quantidade * item.produto.preco }
    carrinho.update(total: total)
  end
end
