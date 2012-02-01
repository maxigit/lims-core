# Spec requirements
require 'labware/spec_helper'
require 'labware/receptacle_examples'

# Model requirements
require 'lims/core/labware/well'

module Lims::Core::Labware
  describe Well  do
    it "belongs  to a plate "  # contained by a plate
    it_behaves_like "receptacle"
  end
end
