require 'active_support/concern'
require 'mass_assignable/config'

module MassAssignable
  module ActiveRecordExtension
    extend ActiveSupport::Concern
    included do
      # Future subclasses will pick up the extension
      class << self
        def inherited_with_mass_assignable(kls) #:nodoc:
          inherited_without_mass_assignable kls
          kls.send(:include, MassAssignable::ActiveRecordExtension)
          kls.class_eval do
            MassAssignable::Config.mass_assigners.each do |assigner|
              attr_protected :as => assigner.to_sym
            end
          end

        end
        alias_method_chain :inherited, :mass_assignable
      end


      # Existing subclasses pick up the model and the inheritance hook extension as well
      self.descendants.each do |kls|
        kls.send(:include, MassAssignable::ActiveRecordExtension)
        kls.class_eval do
          MassAssignable::Config.mass_assigners.each do |assigner|
            attr_protected :as => assigner.to_sym
          end
        end
      end
    end

  end
end