require 'active_support/concern'
require 'active_record'
require 'mass_assignable'







describe MassAssignable do

  before :each do
    ActiveRecord::Base.stub(:connected?){true}
    MassAssignable::Railtie.run_initializers
  end


  it "should make all children of a class including ActiveModel::MassAssignmentSecurity call attr_protected" do
    ::ActiveRecord::Base.should_receive(:attr_protected)
    Class.new(::ActiveRecord::Base)
  end

  it "should make all descendant  of a class including ActiveModel::MassAssignmentSecurity call attr_protected" do
    ::ActiveRecord::Base.should_receive(:attr_protected).exactly(3).times
    parent = Class.new(::ActiveRecord::Base)
    child = Class.new(parent)
    grandchild = Class.new(child)
  end

  it "should make all descendant  of a class including ActiveModel::MassAssignmentSecurity call attr_protected even if the hierarchy was defined before" do
    base = Class.new()
    base.send(:extend, ::ActiveSupport::DescendantsTracker)
    base.should_receive(:attr_protected).exactly(3).times
    parent = Class.new(base)
    child = Class.new(parent)
    grandchild = Class.new(child)
    base.send(:include, ::MassAssignable)
  end

  it "should use admin as default role for mass assignment" do
    ::ActiveRecord::Base.should_receive(:attr_protected).with(:admin)
    Class.new(::ActiveRecord::Base)
  end

  it "should allow to configure the role used for mass assignment" do
    MassAssignable::Config.configure do |c|
      c.mass_assigners = %w(system)
    end
    ::ActiveRecord::Base.should_receive(:attr_protected).with(:system)
    Class.new(::ActiveRecord::Base)
  end

  it "should allow to configure multiple roles for mass assignment" do
    MassAssignable::Config.configure do |c|
      c.mass_assigners = %w(system god superuser)
    end
    ::ActiveRecord::Base.should_receive(:attr_protected).exactly(3).times
    Class.new(::ActiveRecord::Base)
  end

end