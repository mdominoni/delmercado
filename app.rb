require_relative 'shotgun'
require_relative 'config/settings'

UTC_OFFSET = '-03:00' # Buenos Aires

class Main < Sinatra::Base
  use Rack::Session::Cookie, key: 'delmercado', secret: 'p85m0s0v1e9l9e4z'
  use Rack::MethodOverride
  helpers Shield::Helpers

  set public_folder: File.expand_path('public', root), views: File.expand_path(File.join('app', 'views'), root)

  $:.unshift File.expand_path('lib', root)

  before do
    persist_session!
  end
end

Dir[File.expand_path(File.join('app', '**', '*.rb'), Main.root)].each do |file|
  require file
end

Malone.connect url: Settings::MALONE_URL
Ohm.connect url: Settings::REDIS_URL
