# encoding: utf-8

class Main
  helpers do
    # for routes
    def ensure_authenticated model
      error(401) unless authenticated model
    end

    def redirect_to_home
      redirect '/'
    end

    def redirect_to_sign_in
      redirect '/sign-in'
    end

    def not_found(msg = 'Not found')
      halt 404, msg
    end

    # for routes and templates
    def current_user
      authenticated User
    end

    def current_admin
      authenticated Admin
    end

    # for templates
    def errors_for obj, messages
      obj.errors.map do |attrib, errors|
        errors.map do |error|
          messages[attrib][error]
        end
      end.flatten
    end
  end
end
