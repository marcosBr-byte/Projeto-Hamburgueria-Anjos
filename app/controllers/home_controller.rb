class HomeController < ApplicationController
    def index
        ordem = { "hamburgueres" => 1, "combos" => 2, "bebidas" => 3 }
        @destaques = Produto.where(destaque: true).sort_by { |p| ordem[p.categoria] || 99 }
    end
end
