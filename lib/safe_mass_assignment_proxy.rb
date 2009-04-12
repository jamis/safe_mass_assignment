module SafeMassAssignmentProxy
  def self.included(base)
    base.alias_method_chain :create, :safe_mass_assignment
    base.alias_method_chain :create!, :safe_mass_assignment
  end

  def create_with_safe_mass_assignment(attributes={}, protected_attributes={})
    create_without_safe_mass_assignment(attributes) do |record|
      record.send(:mass_assign, protected_attributes)
      yield record if block_given?
    end
  end

  def create_with_safe_mass_assignment!(attributes={}, protected_attributes={})
    create_without_safe_mass_assignment!(attributes) do |record|
      record.send(:mass_assign, protected_attributes)
      yield record if block_given?
    end
  end
end
