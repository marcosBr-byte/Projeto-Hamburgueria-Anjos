class CarrinhoController < ApplicationController
  before_action :buscar_ou_criar_carrinho, only: [:index, :add_produto, :remove_produto, :limpar_todos_os_itens] # rubocop:disable Layout/SpaceInsideArrayLiteralBrackets
  def index
    @itens = @carrinho.item_carrinhos.includes(:produto)
    @produtos = Produto.where(id: @itens.map(&:produto_id)).with_attached_imagem.index_by(&:id)
    @total_carrinho = calcular_total
  end

  def add_produto
    produto = Produto.find(params[:produto_id] || params[:id])
    item = @carrinho.item_carrinhos.find_by(produto_id: produto.id)

    if item
      item.update(quantidade: item.quantidade.to_i + 1)
    else
      @carrinho.item_carrinhos.create(produto_id: produto.id, quantidade: 1)
    end

    redirect_to index_carrinho_path, notice: "Produto adicionado ao carrinho."
  end

  def remove_produto
    item = @carrinho.item_carrinhos.find(params[:id])
    item.destroy
    redirect_to index_carrinho_path, notice: "Produto removido do carrinho."
  end

  def limpar_todos_os_itens
    @carrinho.item_carrinhos.destroy_all
    redirect_to index_carrinho_path, notice: "Carrinho esvaziado."
  end

  private

  def calcular_total
    @carrinho.item_carrinhos.joins(:produto).sum("item_carrinhos.quantidade * produtos.preco")
  end

  def buscar_ou_criar_carrinho
    @carrinho = Carrinho.find_or_create_by(user_id: usuario_logado.id)
  end
end
