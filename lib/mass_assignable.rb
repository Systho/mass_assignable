require 'active_support/concern'
require 'active_model/mass_assignment_security'
require 'rails/railtie'


module MassAssignable
  extend ActiveSupport::Concern

    included do
      class_eval do
        def self.inherited subclass
          super
          ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
          MassAssignable::Config.mass_assigners.each do |assigner|
            subclass.attr_protected assigner.to_sym
          end
        end
      end
    end


end

module MassAssignable::Config
  extend self

  attr_accessor :mass_assigners
  def mass_assigners
    @mass_assigners ||= %w(admin)
  end

  def configure(&block)
    yield(self) if block_given?
  end

end


module MassAssignable
  class Railtie < Rails::Railtie
    initializer "mass_assignable.hook_into_mass_assignment_security" do
      ActiveModel::MassAssignmentSecurity.send(:include, MassAssignable)
    end
  end
end







