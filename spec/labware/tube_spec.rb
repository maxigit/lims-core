# Spec requirements
require 'labware/spec_helper'
require 'labware/located_examples'
require 'labware/receptacle_examples'
require 'labware/labellable_examples'

# Model requirements
require 'lims/core/labware/tube'

module Lims::Core::Labware
  describe Tube  do
    it_behaves_like "located" 
    it_behaves_like "receptacle"
    it_behaves_like "labellable"
  end
end
