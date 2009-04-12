require 'safe_mass_assignment'
require 'safe_mass_assignment_proxy'

ActiveRecord::Base.send :include, SafeMassAssignment
ActiveRecord::Associations::AssociationCollection.send :include, SafeMassAssignmentProxy
