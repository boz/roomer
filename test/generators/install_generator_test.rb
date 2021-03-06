require "test_helper"
require "generators/roomer/install/install_generator"

class InstallGeneratorTest < Rails::Generators::TestCase
  tests Roomer::Generators::InstallGenerator
  destination File.expand_path("../../tmp", __FILE__)
  setup :prepare_destination

  test "assert initializer file created" do
    run_generator
    assert_file "config/initializers/roomer.rb"
  end
end
