# encoding: utf-8

require 'securerandom'

module PasswordRecovery
  def self.init user
    token = SecureRandom.hex(10)

    user.key[:password_reset_token].setex(86400 * 2, token)

    deliver user, token
  end

  def self.deliver user, token
    Malone.deliver(from:    Settings::MAIL_FROM,
                   to:      user.email,
                   subject: 'Instrucciones para reestablecer tu contraseña',
                   text:    MESSAGE % [user.id, token])
  end

  def self.authenticate id, token
    return unless user = User[id]
    return unless user.key[:password_reset_token].get == token

    return user
  end

  MESSAGE = <<-EOT
    Saludos,

    Recientemente solicitaste reestablecer tu contraseña.

    Para continuar, seguí el siguiente enlace:

    http://#{Settings::HOST}/password/reset/%s/%s
  EOT
end
