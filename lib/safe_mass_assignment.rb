module SafeMassAssignment
  def self.included(base)
    base.extend(ClassMethods)
    base.alias_method_chain :initialize, :safe_mass_assignment
    base.alias_method_chain :update_attributes, :safe_mass_assignment
    base.alias_method_chain :update_attributes!, :safe_mass_assignment
  end

  def initialize_with_safe_mass_assignment(attributes=nil, protected_attributes={})
    initialize_without_safe_mass_assignment(attributes) do
      mass_assign(protected_attributes)
      yield self if block_given?
    end
  end

  def update_attributes_with_safe_mass_assignment(attributes={}, protected_attributes={})
    self.attributes = attributes
    mass_assign(protected_attributes)
    save
  end

  def update_attributes_with_safe_mass_assignment!(attributes={}, protected_attributes={})
    self.attributes = attributes
    mass_assign(protected_attributes)
    save!
  end

  def mass_assign(attributes={})
    attributes.each do |name, value|
      send "#{name}=", value
    end
  end
  private :mass_assign

  module ClassMethods
    def self.extended(base)
      base.metaclass.alias_method_chain :create, :safe_mass_assignment
      base.metaclass.alias_method_chain :create!, :safe_mass_assignment
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
end
