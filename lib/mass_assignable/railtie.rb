require 'rails/railtie'
require 'active_support'


module MassAssignable
  class Railtie < Rails::Railtie
    initializer "mass_assignable.hook_into_active_record", :after => "finisher_hook " do |app|
      ActiveSupport.on_load(:active_record) do
        # ugly way to ensure a connection is available
        unless ActiveRecord::Base.connected?
          ActiveRecord::Base.configurations= app.config.database_configuration
          ActiveRecord::Base.establish_connection
        end

        require 'mass_assignable/active_record_extension'
        ActiveRecord::Base.send(:include, MassAssignable::ActiveRecordExtension)
      end
    end
  end
end