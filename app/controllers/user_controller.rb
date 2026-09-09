class UserController < ApplicationController
    def login
      @user = User.new
    end

    def cadastrar
      @user = User.new
    end

    def show
      @user = usuario_logado
      redirect_to "/user/login" unless @user
    end
    def create_login
      dados = params_login
      @user = User.find_by(email: dados[:email])

      if @user.authenticate(dados[:password])
        session[:user_id] = @user.id

        if @user.admin?
          redirect_to admin_path

        else
          redirect_to root_path
        end

      else
        @user = User.new
        flash.now[:alert] = "Email ou senha inválidos"
        render :login, status: :unprocessable_entity
      end
    end

    def create_cadastrar
      @user = User.new(params_cadastrar)
      @user.role = :cliente
      if @user.save
        redirect_to "/user/login", notice: "Cadastro realizado com sucesso"
      else
        flash.now[:alert] = "Erro ao cadastrar"
        render :cadastrar, status: :unprocessable_entity
      end
    end

    def logout
      session[:user_id] = nil
      redirect_to root_path
    end

    private

    def params_login
      params.require(:user).permit(:email, :password)
    end

    def params_cadastrar
      params.require(:user).permit(:nome,:email,:password,:password_confirmation)
    end
end
