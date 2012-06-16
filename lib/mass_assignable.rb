require 'active_model'
require 'active_support/concern'

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

ActiveModel::MassAssignmentSecurity.send(:include, MassAssignable)





