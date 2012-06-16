class MassAssignmentProtected
  include ActiveModel::MassAssignmentSecurity
end

describe MassAssignable do
  it "should make all children of ActiveRecord:Base call attr_protected" do
    MassAssignmentProtected.should_receive(:attr_protected)
    Class.new(MassAssignmentProtected)
  end

  it "should use admin as default role for mass assignment" do
    MassAssignmentProtected.should_receive(:attr_protected).with(:admin)
    Class.new(MassAssignmentProtected)
  end

  it "should allow to configure the role used for mass assignment" do
    MassAssignable::Config.configure do |c|
      c.mass_assigners = %w(system)
    end
    MassAssignmentProtected.should_receive(:attr_protected).with(:system)
    Class.new(MassAssignmentProtected)
  end

  it "should allow to configure multiple roles for mass assignment" do
    MassAssignable::Config.configure do |c|
      c.mass_assigners = %w(system god superuser)
    end
    MassAssignmentProtected.should_receive(:attr_protected).exactly(3).times
    Class.new(MassAssignmentProtected)
  end

end