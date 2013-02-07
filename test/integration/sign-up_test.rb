# encoding: utf-8

require_relative 'integration_test_helper'

class SignUpTest < CapybaraTestCase
  test "sign-up" do
    visit '/sign-up'

    assert has_content?('Creá tu cuenta (es gratis)')

    click_button 'Crear cuenta'

    assert has_content?('Tu cuenta no pudo ser creada')

    fill_in 'user__email',    :with => 'foo@bar.com'
    fill_in 'user__password', :with => '1234'

    click_button 'Crear cuenta'

    assert has_content?('Tu cuenta ha sido creada')
  end
end
