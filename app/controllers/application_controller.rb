class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  helper_method :usuario_logado

  def usuario_logado
    if session[:user_id]
      @usuario_logado = User.find_by(id: session[:user_id])
    end
    @usuario_logado
  end
end
