RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    begin
      DatabaseCleaner.start

      ActsAsTenant.without_tenant do
        FactoryBot.lint
      end
    ensure
      DatabaseCleaner.clean
    end
  end
end
