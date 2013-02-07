# encoding: utf-8

require_relative 'integration_test_helper'

class SignInTest < CapybaraTestCase
  setup do
    User.create(email: 'foo@bar.com', password: '1234')
  end

  test "sign-up" do
    visit '/sign-in'

    assert has_content?('Inicio de sesión')

    click_button 'Iniciar sesión'

    assert has_content?('Error en el email o en la contraseña')

    fill_in 'session__email',    :with => 'foo@bar.com'
    fill_in 'session__password', :with => '1234'

    click_button 'Iniciar sesión'

    assert has_content?('Iniciaste sesión')
  end
end
