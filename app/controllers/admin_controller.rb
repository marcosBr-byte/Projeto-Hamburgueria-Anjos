class AdminController < ApplicationController
  before_action :require_admin
  def index
    @total_produtos = Produto.count
    @total_modificados = Produto.where("updated_at > created_at").count
  end

  private

  def require_admin
    unless usuario_logado&.admin?
      flash[:alert] = "Acesso não autorizado"
      redirect_to root_path
    end
  end
end
