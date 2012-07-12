require 'rails/railtie'
require 'active_support'


module MassAssignable
  class Railtie < Rails::Railtie
    initializer "mass_assignable.hook_into_active_record" do
      ActiveSupport.on_load(:active_record) do
        require 'mass_assignable/active_record_extension'
        ActiveRecord::Base.send(:include, MassAssignable::ActiveRecordExtension)
      end
    end
  end
end