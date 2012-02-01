# Spec requirements
require 'labware/spec_helper'
require 'labware/receptacle_examples'

# Model requirements
require 'lims/core/labware/lane'

module Lims::Core::Labware
  describe Lane  do
    it "belongs  to a flowcell "  # contained by a flowcell
    it_behaves_like "receptacle"
  end
end
