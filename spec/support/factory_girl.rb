RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    begin
      DatabaseCleaner.start

      ActsAsTenant.without_tenant do
        FactoryGirl.lint
      end
    ensure
      DatabaseCleaner.clean
    end
  end
end
