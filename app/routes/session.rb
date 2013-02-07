# encoding: utf-8

class Main
  before '/sign-in' do
    @expire = Settings::REMEMBER_EXPIRE
  end

  get '/sign-in' do
    haml :'sign-in'
  end

  post '/sign-in' do
    if login User, params[:session][:email], params[:session][:password], params[:session][:remember_me], @expire
      session[:success] = 'Iniciaste sesión.'

      redirect params[:return] if params[:return].to_s.match /\A[\/a-z0-9\-]+\z/i # prevent url hijacking
      redirect_to_home
    end

    session[:error] = 'Error en el email o en la contraseña.'
    redirect_to_sign_in
  end

  get '/sign-out' do
    logout User
    session[:success] = 'Cerraste tu sesión.'
    redirect_to_home
  end
end
