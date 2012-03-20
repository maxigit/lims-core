# Spec requirements
require 'labware/spec_helper'
require 'labware/receptacle_examples'

# Model requirements
require 'lims/core/labware/flowcell'

module Lims::Core::Labware
  describe Flowcell::Lane  do
    it "belongs  to a flowcell "  # contained by a flowcell
    it_behaves_like "receptacle"
  end
end
