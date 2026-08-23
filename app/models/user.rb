class User < ApplicationRecord
    has_secure_password
    has_one :carrinho, dependent: :destroy
    has_many :pedido, dependent: :destroy

    validates :email,presence: true, uniqueness: true

    enum :role,{
        cliente: 1,
        admin: 2
    }
end
