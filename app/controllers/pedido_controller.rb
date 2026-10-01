class PedidoController < ApplicationController
  before_action :usuario_logado, only: [:index] # rubocop:disable Layout/SpaceInsideArrayLiteralBrackets
  def index
  end
end
