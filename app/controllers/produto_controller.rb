class ProdutoController < ApplicationController
  before_action :admin_required, only: [:index, :new, :create, :edit, :update, :destroy] # rubocop:disable Layout/SpaceInsideArrayLiteralBrackets
  before_action :set_produto, only: [:show, :edit, :update, :destroy] # rubocop:disable Layout/SpaceInsideArrayLiteralBrackets

  def index
    @categoria = params[:categoria]
    @produtos = Produto.with_attached_imagem.order(created_at: :desc)
    @produtos = @produtos.where(categoria: @categoria) if @categoria.present?
  end

  def new
    @produto = Produto.new
  end

  def show; end

  def edit; end

  def create
    @produto = Produto.new(params_produto)
    if @produto.save
      redirect_to "/produto/index", notice: "Produto salvo com sucesso."
    else
      flash.now[:alert] = "Erro ao salvar o produto."
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @produto.update(params_produto)
      redirect_to "/produto/index", notice: "Produto atualizado com sucesso."
    else
      flash.now[:alert] = "Erro ao atualizar o produto."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @produto.destroy
      redirect_to "/produto/index", notice: "Produto deletado com sucesso."
    else
      redirect_to "/produto/index", alert: "Erro ao deletar o produto."
    end
  end

  def novidades
    @categoria = params[:categoria]
    @produtos = Produto.with_attached_imagem.order(created_at: :desc)
    @produtos = @produtos.where(categoria: @categoria) if @categoria.present?
    @produtos = @produtos.limit(8)
  end

  def promocoes
    @produtos = Produto.with_attached_imagem.where(destaque: true)
  end

  def cardapio
    ordem = { "hambúrgueres" => 1, "combos" => 2, "bebidas" => 3 }
    @categoria = params[:categoria].to_s.downcase
    produtos = Produto.with_attached_imagem.to_a
    produtos = produtos.select { |p| p.categoria.to_s.downcase == @categoria } if @categoria.present?
    @produtos = produtos.sort_by { |p| ordem[p.categoria.to_s.downcase] || 99 }
  end

  private

  def admin_required
    user = User.find_by(id: session[:user_id])
    return if user&.admin?

    flash[:alert] = "Acesso restrito ao administrador."
    redirect_to root_path
  end

  def set_produto
    @produto = Produto.find(params[:id])
  end

  def params_produto
    params.require(:produto).permit(:nome, :preco, :descricao, :estoque, :categoria, :imagem, :ativo, :destaque)
  end
end
