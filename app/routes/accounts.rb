# encoding: utf-8

class Main
  get '/sign-up' do
    @user = CreateUser.new({})
    haml :'sign-up'
  end

  post '/sign-up' do
    @user = CreateUser.new(params[:user])

    if @user.valid?
      @user.create

      logout User # because we allow signed-in users to create new accounts
      login User, @user.email, @user.password
      session[:success] = 'Tu cuenta ha sido creada.'

      redirect_to_home
    end

    @error_messages = {
      email: {
        not_present: 'Tenés que ingresar tu dirección de email.',
        not_email:   'La dirección de email es incorrecta.',
        not_unique:  'Ya existe una cuenta con esa dirección de email.'
      },
      password: {
        not_present: 'Tenés que especificar una contraseña.'
      }
    }

    session[:error] = 'Tu cuenta no pudo ser creada.'
    haml :'sign-up'
  end

  get '/password/recovery' do
    haml :'password/recovery'
  end

  post '/password/recovery' do
    if user = User.fetch(params[:email])
      PasswordRecovery.init(user)
      redirect '/password/instructions'
    end

    session[:error] = 'No existe ninguna cuenta con ese email.'
    redirect '/password/recovery'
  end

  get '/password/instructions' do
    haml :'password/instructions'
  end

  before '/password/reset/:id/:token' do
    @id    = params[:id]
    @token = params[:token]

    unless @user = PasswordRecovery.authenticate(@id, @token)
      not_found 'La URL especificada puede haber expirado.'
    end
  end

  get '/password/reset/:id/:token' do
    @reset = PasswordReset.new({})
    haml :'password/reset'
  end

  post '/password/reset/:id/:token' do
    @reset = PasswordReset.new(params[:user])

    if @reset.valid?
      @user.update(password: @reset.password) && authenticate(@user)

      session[:success] = 'La contraseña ha sido reestablecida.'
      redirect_to_home
    end

    @error_messages = {
      password:              { not_present: 'Tenés que especificar una contraseña.' },
      password_confirmation: { not_valid:   'La confirmación debe ser idéntica a la contraseña.' }
    }

    haml :'/password/reset'
  end
end
