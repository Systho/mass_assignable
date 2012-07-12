require 'active_support/concern'
require 'active_record'
require 'rails/railtie'

require 'active_record/railtie'


module MassAssignable
  extend ActiveSupport::Concern

    included do
      class_eval do
        def self.inherited subclass
          super
          MassAssignable::Config.mass_assigners.each do |assigner|
            subclass.attr_protected assigner.to_sym
          end
        end
      end
      descendants.each do |klass|
        klass.class_eval do
          MassAssignable::Config.mass_assigners.each do |assigner|
            attr_protected assigner.to_sym
          end
          def self.inherited subclass
            super
            MassAssignable::Config.mass_assigners.each do |assigner|
              subclass.attr_protected assigner.to_sym
            end
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
    initializer "mass_assignable.hook_into_mass_assignment_security", :after => "finisher_hook " do
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send(:include, MassAssignable)
      end
    end
  end
end







