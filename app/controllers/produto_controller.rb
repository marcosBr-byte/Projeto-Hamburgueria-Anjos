class ProdutoController < ApplicationController
  before_action :admin_required, only: [:index, :new, :create, :edit, :update, :destroy] # rubocop:disable Layout/SpaceInsideArrayLiteralBrackets
  before_action :set_produto, only: [:show, :edit, :update, :destroy] # rubocop:disable Layout/SpaceInsideArrayLiteralBrackets

  def index
    @produtos = Produto.all
    @categoria = params[:categoria]
    @produtos = Produto.order(created_at: :desc)
    @produtos = @produtos.where(categoria: @categoria) if @categoria.present?
  end

  def new
    @produto = Produto.new
  end

  def show;end

  def edit; end

  def create
    @produto = Produto.new(params_produto)
    if @produto.save
      redirect_to "/produto/index"
      puts "produto salvo com sucesso"
    else
      flash[:alert] = "Erro ao salvar o produto"
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @produto.update(params_produto)
      redirect_to "/produto/index"
      puts "produto atualizado com sucesso"
    else
      flash[:alert] = "Erro ao atualizar o produto"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @produto.destroy
      redirect_to "/produto/index"
      puts "produto deletado com sucesso"
    else
      flash[:alert] = "Erro ao deletar o produto"
      render :index, status: :unprocessable_entity
    end
  end

  def hamburgueres
    @produtos = Produto.where(categoria: "hamburgueres")
  end

  def combos
    @produtos = Produto.where(categoria: "combos")
  end

  def bebidas
    @produtos = Produto.where(categoria: "bebidas")
  end


  def buscar_hamburgueres
    @produto = Produto.find_by(id: params[:id])

    if @produto
      redirect_to index_produto_path(@produto)
    else
      flash[:alert] = "Produto não encontrado."
      render :masculino, status: :unprocessable_entity
    end
  end

  def buscar_combos
    @produto = Produto.find_by(id: params[:id])

    if @produto
      redirect_to index_produto_path(@produto)
    else
      flash[:alert] = "Produto não encontrado."
      render :feminino, status: :unprocessable_entity
    end
  end

  def buscar_bebidas
    @produto = Produto.find_by(id: params[:id])

    if @produto
      redirect_to index_produto_path(@produto)
    else
      flash[:alert] = "Produto não encontrado."
      render :kids, status: :unprocessable_entity
    end
  end

  def novidades
    @categoria = params[:categoria]
    @produtos = Produto.order(created_at: :desc)
    @produtos = @produtos.where(categoria: @categoria) if @categoria.present?
    @produtos = @produtos.limit(8)
  end

  def cardapio
    ordem = { "hamburgueres" => 1, "combos" => 2, "bebidas" => 3 }
    @produtos = Produto.where(ativo: true).includes(imagem_attachment: :blob)
    @produtos = @produtos.sort_by { |p| ordem[p.categoria] || 99 }
  end

  private

  def admin_required
    user = User.find_by(id: session[:user_id])
    unless user&.admin?
      flash[:alert] = "Acesso restrito ao administrador."
      redirect_to root_path
    end
  end

  def set_produto
    @produto = Produto.find(params[:id])
  end

  def params_produto
    params.require(:produto).permit(:nome, :preco, :descricao, :estoque, :categoria, :imagem, :ativo, :destaque)
  end
end
