


module MassAssignable

  module Config
    extend self

    attr_accessor :mass_assigners
    def mass_assigners
      @mass_assigners ||= %w(admin)
    end

    def configure(&block)
      yield(self) if block_given?
    end

  end

end