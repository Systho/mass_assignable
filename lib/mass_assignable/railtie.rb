require 'rails/railtie'
require 'active_support'


module MassAssignable
  class Railtie < Rails::Railtie
    initializer "mass_assignable.hook_into_active_record", :after => "finisher_hook " do
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.establish_connection unless ActiveRecord::Base.connected?
        require 'mass_assignable/active_record_extension'
        ActiveRecord::Base.send(:include, MassAssignable::ActiveRecordExtension)
      end
    end
  end
end