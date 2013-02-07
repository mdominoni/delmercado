# encoding: utf-8

require_relative '../test_helper'
require "capybara/dsl"

class CapybaraTestCase < Test::Unit::TestCase
  include Capybara::DSL

  def teardown
    # save_screenshot(__name__) unless passed?
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

  def save_screenshot(name)
    filename = File.join(File.dirname(__FILE__), '..', '..', 'tmp', "#{Time.now.strftime("%Y-%m-%d_%H%M%S")}_#{name}.png")
    page.driver.browser.save_screenshot(filename)
  end

  def sign_in email, password='monkey'
    visit '/sign-in'

    fill_in 'session__email',    with: email
    fill_in 'session__password', with: password

    click_button 'commit'
  end
end

Capybara.app = Main
