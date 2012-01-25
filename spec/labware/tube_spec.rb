# Spec requirements
require 'labware/spec_helper'
require 'labware/located_examples'

# Model requirements
require 'lims/core/labware/tube'

module Lims::Core::Labware
  describe Tube  do
    it_behaves_like "located" 
    it "has a chemical content" # use shared example?
  end
end
